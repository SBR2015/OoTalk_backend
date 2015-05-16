require 'test_helper'

class DemosControllerTest < ActionController::TestCase
  setup do
    @demo = demos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:demos)
  end

  test "should create demo" do
    assert_difference('Demo.count') do
      post :create, demo: { duedate: @demo.duedate, name: @demo.name }
    end

    assert_response 201
  end

  test "should show demo" do
    get :show, id: @demo
    assert_response :success
  end

  test "should update demo" do
    put :update, id: @demo, demo: { duedate: @demo.duedate, name: @demo.name }
    assert_response 204
  end

  test "should destroy demo" do
    assert_difference('Demo.count', -1) do
      delete :destroy, id: @demo
    end

    assert_response 204
  end
end
