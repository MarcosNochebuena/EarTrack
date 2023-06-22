require "test_helper"

class EarringsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @earring = earrings(:one)
  end

  test "should get index" do
    get earrings_url
    assert_response :success
  end

  test "should get new" do
    get new_earring_url
    assert_response :success
  end

  test "should create earring" do
    assert_difference("Earring.count") do
      post earrings_url, params: { earring: { age: @earring.age, earring: @earring.earring, gender: @earring.gender, key_id_id: @earring.key_id_id, status: @earring.status } }
    end

    assert_redirected_to earring_url(Earring.last)
  end

  test "should show earring" do
    get earring_url(@earring)
    assert_response :success
  end

  test "should get edit" do
    get edit_earring_url(@earring)
    assert_response :success
  end

  test "should update earring" do
    patch earring_url(@earring), params: { earring: { age: @earring.age, earring: @earring.earring, gender: @earring.gender, key_id_id: @earring.key_id_id, status: @earring.status } }
    assert_redirected_to earring_url(@earring)
  end

  test "should destroy earring" do
    assert_difference("Earring.count", -1) do
      delete earring_url(@earring)
    end

    assert_redirected_to earrings_url
  end
end
