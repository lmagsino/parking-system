require "application_system_test_case"

class ParkingLotsTest < ApplicationSystemTestCase
  setup do
    @parking_lot = parking_lots(:one)
  end

  test "visiting the index" do
    visit parking_lots_url
    assert_selector "h1", text: "Parking lots"
  end

  test "should create parking lot" do
    visit parking_lots_url
    click_on "New parking lot"

    click_on "Create Parking lot"

    assert_text "Parking lot was successfully created"
    click_on "Back"
  end

  test "should update Parking lot" do
    visit parking_lot_url(@parking_lot)
    click_on "Edit this parking lot", match: :first

    click_on "Update Parking lot"

    assert_text "Parking lot was successfully updated"
    click_on "Back"
  end

  test "should destroy Parking lot" do
    visit parking_lot_url(@parking_lot)
    click_on "Destroy this parking lot", match: :first

    assert_text "Parking lot was successfully destroyed"
  end
end
