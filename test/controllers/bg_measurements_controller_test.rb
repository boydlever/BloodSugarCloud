require 'test_helper'

class BgMeasurementsControllerTest < ActionController::TestCase
  setup do
    @bg_measurement = bg_measurements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bg_measurements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bg_measurement" do
    assert_difference('BgMeasurement.count') do
      post :create, bg_measurement: { mg_dl: @bg_measurement.mg_dl, notes: @bg_measurement.notes, patient_id: @bg_measurement.patient_id }
    end

    assert_redirected_to bg_measurement_path(assigns(:bg_measurement))
  end

  test "should show bg_measurement" do
    get :show, id: @bg_measurement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bg_measurement
    assert_response :success
  end

  test "should update bg_measurement" do
    patch :update, id: @bg_measurement, bg_measurement: { mg_dl: @bg_measurement.mg_dl, notes: @bg_measurement.notes, patient_id: @bg_measurement.patient_id }
    assert_redirected_to bg_measurement_path(assigns(:bg_measurement))
  end

  test "should destroy bg_measurement" do
    assert_difference('BgMeasurement.count', -1) do
      delete :destroy, id: @bg_measurement
    end

    assert_redirected_to bg_measurements_path
  end
end
