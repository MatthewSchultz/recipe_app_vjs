require "application_system_test_case"

class RootTest < ApplicationSystemTestCase
  test "visiting root" do
    visit '/'
    assert_selector "h1", text: "Recipes"
  end
end
