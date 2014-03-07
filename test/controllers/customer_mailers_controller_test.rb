require 'test_helper'

class CustomerMailersControllerTest < ActionController::TestCase
  setup do
    @customer_mailer = customer_mailers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_mailers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_mailer" do
    assert_difference('CustomerMailer.count') do
      post :create, customer_mailer: { email: @customer_mailer.email, name: @customer_mailer.name }
    end

    assert_redirected_to customer_mailer_path(assigns(:customer_mailer))
  end

  test "should show customer_mailer" do
    get :show, id: @customer_mailer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer_mailer
    assert_response :success
  end

  test "should update customer_mailer" do
    patch :update, id: @customer_mailer, customer_mailer: { email: @customer_mailer.email, name: @customer_mailer.name }
    assert_redirected_to customer_mailer_path(assigns(:customer_mailer))
  end

  test "should destroy customer_mailer" do
    assert_difference('CustomerMailer.count', -1) do
      delete :destroy, id: @customer_mailer
    end

    assert_redirected_to customer_mailers_path
  end
end
