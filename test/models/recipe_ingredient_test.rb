require 'test_helper'

class RecipeIngredientTest < ActiveSupport::TestCase
  test 'assert empty ingredient does not cause error' do
    ri = RecipeIngredient.new

    # this will cause an error if the accessor is incorrectly written:
    assert_nil ri.ingredient_name
  end

  test 'assert validations function' do
    ri = RecipeIngredient.first

    ri.qty = nil
    assert_not ri.save

    ri.unit = nil
    assert_not ri.save

    assert_raises Exception do
      ri.unit = 'Moo'
    end
  end

  test 'should not be able to have duplicate ingredient' do
    ri = RecipeIngredient.first
    ri2 = ri.dup

    ri2.recipe = ri.recipe
    ri2.ingredient_name = ri.ingredient_name

    assert_not ri2.save
  end
end
