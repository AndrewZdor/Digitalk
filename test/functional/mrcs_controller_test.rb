require 'test_helper'

class MrcsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mrcs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mrc" do
    assert_difference('Mrc.count') do
      post :create, :mrc => { }
    end

    assert_redirected_to mrc_path(assigns(:mrc))
  end

  test "should show mrc" do
    get :show, :id => mrcs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => mrcs(:one).to_param
    assert_response :success
  end

  test "should update mrc" do
    put :update, :id => mrcs(:one).to_param, :mrc => { }
    assert_redirected_to mrc_path(assigns(:mrc))
  end

  test "should destroy mrc" do
    assert_difference('Mrc.count', -1) do
      delete :destroy, :id => mrcs(:one).to_param
    end

    assert_redirected_to mrcs_path
  end
end
