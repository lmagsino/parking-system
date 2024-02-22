require "test_helper"

class ParkingLotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parking_lot = parking_lots(:one)
  end

  test "should get index" do
    get parking_lots_url
    assert_response :success
  end

  test "should get new" do
    get new_parking_lot_url
    assert_response :success
  end

  test "should create parking_lot" do
    assert_difference("ParkingLot.count") do
      post parking_lots_url, params: { parking_lot: {  } }
    end

    assert_redirected_to parking_lot_url(ParkingLot.last)
  end

  test "should show parking_lot" do
    get parking_lot_url(@parking_lot)
    assert_response :success
  end

  test "should get edit" do
    get edit_parking_lot_url(@parking_lot)
    assert_response :success
  end

  test "should update parking_lot" do
    patch parking_lot_url(@parking_lot), params: { parking_lot: {  } }
    assert_redirected_to parking_lot_url(@parking_lot)
  end

  test "should destroy parking_lot" do
    assert_difference("ParkingLot.count", -1) do
      delete parking_lot_url(@parking_lot)
    end

    assert_redirected_to parking_lots_url
  end
end
