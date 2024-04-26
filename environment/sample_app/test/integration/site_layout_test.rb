require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "home" do
    get root_path
    assert_template "static_pages/home"
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_url
  end

  test "contact" do
    get contact_path
    assert_select "title", full_title("Contact")
  end

  test "signup" do
    get signup_path
    assert_select "title", full_title("Sign up")
  end
end
