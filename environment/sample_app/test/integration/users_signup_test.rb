require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    invalid_params = {
      name: "",
      email: "user@invalid",
      password: "111",
      password_confirmation: "222"
    }
    assert_no_difference 'User.count' do
      post users_path, params: { user: invalid_params }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    errors = assert_select '.field_with_errors'
    assert_equal invalid_params.length * 2, errors.length
  end

  test "valid signup information" do
    get signup_path
    valid_params = {
      name: "Shoya Iikawa",
      email: "user@valid.com",
      password: "12345678",
      password_confirmation: "12345678"
    }
    assert_difference 'User.count', 1 do
      post users_path, params: { user: valid_params }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div.alert-success'
  end
end
