require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @admin_user = users(:admin)
  end

  test "should get signup" do
    get signup_path
    assert_response :success
    assert_select "title", full_title('Sign up')
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: {
      name: @user.name,
      email: @user.email
    }}

    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: {
      name: @user.name,
      email: @user.email
    }}
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {user: {
      name: @other_user.name,
      email: @other_user.email,
      password: "password",
      password_confirmation: "password",
      admin: true
    }}
    @other_user.reload
    assert_not @other_user.admin?
  end

  test "should delete able to only admin" do
    id = @other_user.id
    delete user_path(@other_user)
    assert User.find_by(id:)

    log_in_as @user
    delete user_path @other_user
    assert User.find_by(id:)

    log_in_as @admin_user
    delete user_path @other_user
    assert_not User.find_by(id:)

    delete user_path @admin_user
    assert User.find_by(id: @admin_user.id)
  end
end
