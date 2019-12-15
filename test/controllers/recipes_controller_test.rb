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
    get recipes_url
    assert_response :success
  end

  test "should get new" do
    get new_recipe_url
    assert_response :success
  end

  test "should create recipe" do
    assert_difference('Recipe.count') do
      post recipes_url, params: { recipe: { cuisine: @recipe.cuisine, instructions: @recipe.instructions, planning_to_cook_on: @recipe.planning_to_cook_on, title: @recipe.title, tried_before: @recipe.tried_before } }
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
  end

  test "should update recipe" do
    @recipe = Recipe.first
    patch recipe_url(@recipe), params: { recipe: { cuisine: @recipe.cuisine, instructions: @recipe.instructions, planning_to_cook_on: @recipe.planning_to_cook_on, title: @recipe.title, tried_before: @recipe.tried_before } }
    assert_redirected_to recipes_url
  end

  test "should destroy recipe" do
    assert_difference('Recipe.count', -1) do
      delete recipe_url(Recipe.last)
    end

    assert_redirected_to recipes_url
  end
end
