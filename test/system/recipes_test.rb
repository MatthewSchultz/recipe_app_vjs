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

  test "destroying a Recipe" do
    visit recipes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Recipe was successfully destroyed"
  end
end
