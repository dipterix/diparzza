require 'test_helper'

class ClassannouncesControllerTest < ActionController::TestCase
  setup do
    @classannounce = classannounces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:classannounces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create classannounce" do
    assert_difference('Classannounce.count') do
      post :create, classannounce: { classroom_id: @classannounce.classroom_id, content: @classannounce.content, user_id: @classannounce.user_id }
    end

    assert_redirected_to classannounce_path(assigns(:classannounce))
  end

  test "should show classannounce" do
    get :show, id: @classannounce
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @classannounce
    assert_response :success
  end

  test "should update classannounce" do
    patch :update, id: @classannounce, classannounce: { classroom_id: @classannounce.classroom_id, content: @classannounce.content, user_id: @classannounce.user_id }
    assert_redirected_to classannounce_path(assigns(:classannounce))
  end

  test "should destroy classannounce" do
    assert_difference('Classannounce.count', -1) do
      delete :destroy, id: @classannounce
    end

    assert_redirected_to classannounces_path
  end
end
