require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipe = Recipe.new(
      instructions: '<ol><li>Add water to pot, start boiling</li><li>Add salt & vinegar to water</li><li>When water is boiling, add eggs</li><li>Turn off heat, cover, let sit for 10-12 minutes</li><li>Drain water, run cold water over eggs.</li></ol>',
      title: 'Hardboiled Eggs',
      tried_before: false,
      cuisine: 5
    )
  end

  test "should get index" do
    # Assure that root is routed correctly:
    assert_generates '/', controller: 'recipies', action: 'index'
    get recipes_url
    assert_response :success

    # Assert that the page title is set:
    assert_select 'title', 'Recipes'

    # Assert that the page has the correct header:
    assert_select 'h1', 'Recipes'

    # Test that the table is properly styled:
    assert_select 'table.table'

    # Test that there are no show links:
    assert_select 'a', text: 'Show', count: 0

    # Test that all of the recipes are shown:
    assert_select 'tr.recipe', {count: Recipe.count}
  end

  test "should search recipes" do
    get recipes_url(q: Recipe.first.title)
    assert_response :success

    # Assert that the page title is set:
    assert_select 'title', 'Recipes'

    # Assert that the page has the correct header:
    assert_select 'h1', 'Recipes'

    # Test that the table is properly styled:
    assert_select 'table.table'

    # Test that there are no show links:
    assert_select 'a', text: 'Show', count: 0

    # Test that at
    assert_select 'tr.recipe'
  end

  test "should get new" do
    get new_recipe_url
    assert_response :success

    # Assert that the page title is set:
    assert_select 'title', 'Add Recipe'

    # Assert that the page has the correct header:
    assert_select 'h1', 'Add Recipe'

    # Assert that the form is present:
    assert_select 'form.new_recipe'
  end

  test "should create recipe" do
    assert_difference('Recipe.count') do
      post recipes_url, params: {
        recipe: {
          cuisine: 'American',
          instructions: 'test',
          title: 'test',
          tried_before: false
        }
      }
    end

    assert_redirected_to recipes_url
  end

  test "should not show recipe" do
    assert_raise Exception do
      get recipe_url(Recipe.first)
    end
  end

  test "should get edit" do
    get edit_recipe_url(Recipe.first)
    assert_response :success
    # Assert that the form is present:
    assert_select 'form.edit_recipe'
  end

  #test "should update recipe" do
  #  @recipe = Recipe.first
  #  patch recipe_url(@recipe), params: { recipe: { instructions: 'I like turtles' } }
  #  assert_redirected_to recipes_url
  #end

  test "should destroy recipe" do
    assert_difference('Recipe.count', -1) do
      delete recipe_url(Recipe.last)
    end

    assert_redirected_to recipes_url
  end

  test "should show error" do
    post recipes_url, params: { recipe: { title: 'nope' } }

    assert_select '#error_explanation'
  end
end
