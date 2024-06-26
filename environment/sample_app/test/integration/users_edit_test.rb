require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: {
      name: '',
      email: 'invalid',
      password: 'miss',
      password_confirmation: 'miss2'
    }}

    assert_template 'users/edit'
    assert_select 'div.alert', text: "The form contains 4 errors"
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'

    name = "new name"
    email = "new@new.com"
    patch user_path(@user), params: { user: {
      name:,
      email:,
      password: "",
      password_confirmation: ""
    }}

    assert_not flash.empty?
    assert_redirected_to @user
    follow_redirect!
    assert_select "div.alert-success"
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test "should frendly redirect" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    follow_redirect!

    log_out_as
    log_in_as(@user)
    assert_redirected_to @user
  end
end
