require 'test_helper'

class ClassenrollsControllerTest < ActionController::TestCase
  setup do
    @classenroll = classenrolls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:classenrolls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create classenroll" do
    assert_difference('Classenroll.count') do
      post :create, classenroll: { classroom_id: @classenroll.classroom_id, ista: @classenroll.ista, user_id: @classenroll.user_id }
    end

    assert_redirected_to classenroll_path(assigns(:classenroll))
  end

  test "should show classenroll" do
    get :show, id: @classenroll
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @classenroll
    assert_response :success
  end

  test "should update classenroll" do
    patch :update, id: @classenroll, classenroll: { classroom_id: @classenroll.classroom_id, ista: @classenroll.ista, user_id: @classenroll.user_id }
    assert_redirected_to classenroll_path(assigns(:classenroll))
  end

  test "should destroy classenroll" do
    assert_difference('Classenroll.count', -1) do
      delete :destroy, id: @classenroll
    end

    assert_redirected_to classenrolls_path
  end
end
