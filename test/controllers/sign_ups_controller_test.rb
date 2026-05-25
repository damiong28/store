require "test_helper"

class SignUpsControllerTest < ActionDispatch::IntegrationTest
  setup { @user = User.take }

  test "show" do
    get sign_up_path
    assert_response :success
  end

  test "create with valid credentials" do
    post sign_up_path, params: { user: { first_name: "John", last_name: "Doe", email_address: "newuser@example.com", password: "password", password_confirmation: "password" } }

    assert_redirected_to root_path
    assert cookies[:session_id]
  end

  test "create with invalid credentials" do
    post sign_up_path, params: { user: { email_address: @user.email_address, password: "wrong" } }

    assert_response :unprocessable_entity
    assert_select "h1", "Sign Up"
    assert_nil cookies[:session_id]
  end

end
