require "application_system_test_case"

class RecipesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit recipes_url
    assert_selector "h1", text: "Recipes"
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
    within "tr.recipe[data-uuid='#{r2.id}']" do
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
    within "tr.recipe[data-uuid='#{r2.id}']" do
      assert_selector "td:nth-child(6) li", text: 'New Ingredient'
    end

    # Check the old recipe:
    within "tr.recipe[data-uuid='#{r.id}']" do
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
end
