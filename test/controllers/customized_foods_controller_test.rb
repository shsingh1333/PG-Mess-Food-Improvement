require "test_helper"

class CustomizedFoodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customized_food = customized_foods(:one)
  end

  test "should get index" do
    get customized_foods_url
    assert_response :success
  end

  test "should get new" do
    get new_customized_food_url
    assert_response :success
  end

  test "should create customized_food" do
    assert_difference("CustomizedFood.count") do
      post customized_foods_url, params: { customized_food: { description: @customized_food.description, name: @customized_food.name, price: @customized_food.price } }
    end

    assert_redirected_to customized_food_url(CustomizedFood.last)
  end

  test "should show customized_food" do
    get customized_food_url(@customized_food)
    assert_response :success
  end

  test "should get edit" do
    get edit_customized_food_url(@customized_food)
    assert_response :success
  end

  test "should update customized_food" do
    patch customized_food_url(@customized_food), params: { customized_food: { description: @customized_food.description, name: @customized_food.name, price: @customized_food.price } }
    assert_redirected_to customized_food_url(@customized_food)
  end

  test "should destroy customized_food" do
    assert_difference("CustomizedFood.count", -1) do
      delete customized_food_url(@customized_food)
    end

    assert_redirected_to customized_foods_url
  end
end
