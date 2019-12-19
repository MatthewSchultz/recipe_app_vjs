require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  test 'cannot create ingredient too long' do
    i = Ingredient.new(name: '012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789')
    assert_not i.save
    assert_includes i.errors, :name
  end

  test 'cannot create empty ingredient' do
    i = Ingredient.new()
    assert_not i.save
    assert_includes i.errors, :name
  end

  test 'cannot create duplicate ingredient' do
    i = Ingredient.first.dup()
    assert_not i.save
    assert_includes i.errors, :name
  end
end
