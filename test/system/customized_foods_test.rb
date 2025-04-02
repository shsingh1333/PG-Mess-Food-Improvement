require "application_system_test_case"

class CustomizedFoodsTest < ApplicationSystemTestCase
  setup do
    @customized_food = customized_foods(:one)
  end

  test "visiting the index" do
    visit customized_foods_url
    assert_selector "h1", text: "Customized foods"
  end

  test "should create customized food" do
    visit customized_foods_url
    click_on "New customized food"

    fill_in "Description", with: @customized_food.description
    fill_in "Name", with: @customized_food.name
    fill_in "Price", with: @customized_food.price
    click_on "Create Customized food"

    assert_text "Customized food was successfully created"
    click_on "Back"
  end

  test "should update Customized food" do
    visit customized_food_url(@customized_food)
    click_on "Edit this customized food", match: :first

    fill_in "Description", with: @customized_food.description
    fill_in "Name", with: @customized_food.name
    fill_in "Price", with: @customized_food.price
    click_on "Update Customized food"

    assert_text "Customized food was successfully updated"
    click_on "Back"
  end

  test "should destroy Customized food" do
    visit customized_food_url(@customized_food)
    click_on "Destroy this customized food", match: :first

    assert_text "Customized food was successfully destroyed"
  end
end
