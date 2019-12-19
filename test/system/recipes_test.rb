require "application_system_test_case"

class RecipesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit recipes_url
    assert_selector "h1", text: "Recipes"
    take_screenshot
  end

  test "creating a Recipe" do
    visit recipes_url
    click_on "New Recipe"

    select 'Other', from: "Cuisine"
    fill_in "Instructions", with: '<ol><li>Add water to pot, start boiling</li><li>Add salt & vinegar to water</li><li>When water is boiling, add eggs</li><li>Turn off heat, cover, let sit for 10-12 minutes</li><li>Drain water, run cold water over eggs.</li></ol>'
    fill_in "Title", with: 'Hardboiled Egg'
    click_on "Save"

    assert_text "Recipe was successfully created"
    assert_selector 'tr.recipe td:nth-child(1)', text: 'Hardboiled Egg'
  end

  test "updating a Recipe" do

    visit recipes_url
    click_on "Edit", match: :first

    fill_in "Title", with: 'New Title'
    click_on "Save"

    assert_text "Recipe was successfully updated"
    assert_selector 'tr.recipe td:nth-child(1)', text: 'New Title'
  end

  # ISSUE GH-10
  test 'changing an ingredient' do
    # Create a duplicate recipe to mess about with
    r = Recipe.first
    r2 = r.dup
    r2.title = 'New duplicate recipe'
    r2.save

    # Fill it with the same ingredients
    r.recipe_ingredients.each do |ri|
      r2.recipe_ingredients.create(
        ingredient: ri.ingredient,
        qty: ri.qty,
        unit: ri.unit
      )
    end
    i = r.ingredients.first
    i_original_name = i.name

    # Goto recipes page
    visit recipes_url

    # Find the recipe
    within row_for(r2) do
      # Check that the second recipe was created:
      assert_selector 'td:nth-child(1)', text: r2.title

      # Make sure it has the ingredient:
      assert_selector "td:nth-child(6) li", text: i.name

      # Go to the edit page of the recipe:
      click_on 'Edit'
    end

    # Change the ingredient:
    fill_in currently_with: i_original_name, with: 'New Ingredient'
    click_on 'Save'
    assert_text "Recipe was successfully updated"

    # Check the new recipe:
    within row_for(r2) do
      assert_selector "td:nth-child(6) li", text: 'New Ingredient'
    end

    # Check the old recipe:
    within row_for(r) do
      assert_selector "td:nth-child(6) li", text: i_original_name
    end
  end

  test "destroying a Recipe" do
    visit recipes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Recipe was successfully destroyed"
  end

  test 'adding an ingredient' do
    r = Recipe.first

    visit recipes_url
    within row_for(r) do
      click_on 'Edit'
    end

    assert_selector 'a.add-fields', text: 'Add Ingredient'
    ingredients_count = all('.recipe-ingredient').count

    # Try to add an ingredient and assert that the new ingredient is added to the page:
    click_on 'Add Ingredient'
    assert_selector '.recipe-ingredient', count: ingredients_count + 1

    # Fill in some stuff
    fill_in placeholder: 'Ingredient', currently_with: '', with: 'Some Ingredient'
    fill_in placeholder: 'Quantity', currently_with: '', with: '4.6'

    click_on 'Save'

    within row_for(r) do
      # Find the newly added ingredient:
      assert_selector 'td:nth-child(6) li', text: 'Some Ingredient'
      assert_selector 'td:nth-child(6) li', text: '4.6'
    end
  end

  test 'removing an ingredient' do
    r = Recipe.first
    ri = r.recipe_ingredients.last
    ri_name = ri.ingredient.name

    visit edit_recipe_url(r)

    within row_for(ri) do
      # Find the form stuff for this ingredient:
      assert_selector '.ingredient-fields'

      click_on 'Remove'

      # Assert that hitting that button got rid of the fields:
      assert_selector '.ingredient-fields', count: 0
    end

    click_on 'Save'

    # Assert that it was removed:
    within row_for(r) do
      assert_selector 'td:nth-child(6) li', text: ri_name, count: 0
    end
  end
end
