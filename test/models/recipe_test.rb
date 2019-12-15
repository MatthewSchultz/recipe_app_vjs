require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  test "cannot have recipe without title" do
    recipe = Recipe.new
    assert_not recipe.save
    assert_includes recipe.errors, :title
  end

  test "recipe title cannot be greater than 1024 characters" do
    recipe = Recipe.first
    recipe.title = '0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234' # 1025 characters
    assert_not recipe.save
    assert_includes recipe.errors, :title
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
    recipe = Recipe.new(
      cuisine: Recipe.cuisines.values.max + 1
    )
    assert_not recipe.save
    assert_includes recipe.errors, :cuisine

    recipe = Recipe.new(
      cuisine: 'Definitely NOT a cuisine'
    )
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
end
