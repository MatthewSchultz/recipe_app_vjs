require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  test "cannot have recipe without title" do
    recipe = Recipe.new
    assert_not recipe.save
    assert_includes recipe.errors, :title
  end

  test "recipe title cannot be greater than 1024 characters" do
    recipe = Recipe.first
    recipe.title = '012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789'
    assert_not recipe.save
    #assert_includes recipe.errors, :title
  end

  test 'recipe title must be unique' do
    recipe = Recipe.first.dup

    assert_not recipe.save
    assert_includes recipe.errors, :title
  end

  test "cannot have recipe without cuisine" do
    recipe = Recipe.new
    assert_not recipe.save
    assert_includes recipe.errors, :cuisine
  end

  test 'recipe cuisine must be in enum' do
    recipe = Recipe.new
    assert_raises Exception do
      recipe = Recipe.new(
        cuisine: 'Moo'
      )
    end
    assert_not recipe.save
    assert_includes recipe.errors, :cuisine
  end

  test 'planning_to_cook_on must be in the future' do
    recipe = Recipe.new(
      planning_to_cook_on: Time.zone.now - 1.second
    )
    assert_not recipe.save
    assert_includes recipe.errors, :planning_to_cook_on
  end

  test "cannot have recipe without instructions" do
    recipe = Recipe.new
    assert_not recipe.save
    assert_includes recipe.errors, :instructions
  end

  test "instructions cannot have javascript" do
    # Don't allow script tags:
    recipe = Recipe.new(
      instructions: '<script>for (;;) { alert("Alert! This is JavaScript and it is super annoying! Do not allow this!!!!!!"); }</script>'
    )
    assert_not recipe.save
    assert_includes recipe.errors, :instructions

    # Don't allow js attributes:
    recipe = Recipe.new(
      instructions: "<a onclick=\"for (;;) { alert('Alert! This is JavaScript and it is super annoying! Do not allow this!!!!!!'); }\">Totally click this to get monies from a Nigerian Prince!!!</a>"
    )
    assert_not recipe.save
    assert_includes recipe.errors, :instructions
  end

  test "cannot have recipe without tried_before" do
    recipe = Recipe.new
    assert_not recipe.save
    assert_includes recipe.errors, :tried_before
  end

  test 'search should locate recipe by name or ingredient' do
    recipe = Recipe.first
    assert_includes Recipe.search(recipe.title), recipe
    assert_includes Recipe.search(recipe.ingredients.first.name), recipe
  end

  test 'search should exclude stuff' do
    assert_empty Recipe.search('asdfqajwhfaisdjcvn.xzdfajsyhdfasdlfwieufakdksdhfwaefkws')
  end
end
