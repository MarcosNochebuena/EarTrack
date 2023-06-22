require "application_system_test_case"

class EarringsTest < ApplicationSystemTestCase
  setup do
    @earring = earrings(:one)
  end

  test "visiting the index" do
    visit earrings_url
    assert_selector "h1", text: "Earrings"
  end

  test "should create earring" do
    visit earrings_url
    click_on "New earring"

    fill_in "Age", with: @earring.age
    fill_in "Earring", with: @earring.earring
    fill_in "Gender", with: @earring.gender
    fill_in "Key id", with: @earring.key_id_id
    fill_in "Status", with: @earring.status
    click_on "Create Earring"

    assert_text "Earring was successfully created"
    click_on "Back"
  end

  test "should update Earring" do
    visit earring_url(@earring)
    click_on "Edit this earring", match: :first

    fill_in "Age", with: @earring.age
    fill_in "Earring", with: @earring.earring
    fill_in "Gender", with: @earring.gender
    fill_in "Key id", with: @earring.key_id_id
    fill_in "Status", with: @earring.status
    click_on "Update Earring"

    assert_text "Earring was successfully updated"
    click_on "Back"
  end

  test "should destroy Earring" do
    visit earring_url(@earring)
    click_on "Destroy this earring", match: :first

    assert_text "Earring was successfully destroyed"
  end
end
