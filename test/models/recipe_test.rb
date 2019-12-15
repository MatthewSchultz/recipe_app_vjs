require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  test "cannot have recipe without title" do
    recipe = Recipe.new
    assert_not recipe.save
    assert_includes recipe.errors, :title
  end
  test "cannot have recipe without cusine" do
    recipe = Recipe.new
    assert_not recipe.save
    assert_includes recipe.errors, :cusine
  end
  test "cannot have recipe without instructions" do
    recipe = Recipe.new
    assert_not recipe.save
    assert_includes recipe.errors, :instructions
  end
  test "cannot have recipe without tried_before" do
    recipe = Recipe.new
    assert_not recipe.save
    assert_includes recipe.errors, :tried_before
  end
end
