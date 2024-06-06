require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    return false unless user.nil?

    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["postmaster@sandbox5205f6b7fad54ca19c10a00589e06ef1.mailgun.org"], mail.from
    assert_match user.name, mail.body.encoded
    assert_match user.activation_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
    assert_match %(href="http://example.com/account_activations/#{user.activation_token}/edit?email=#{CGI.escape(user.email)}).encode, mail.body.encoded
  end

  test "password_reset" do
    user = users(:michael)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["postmaster@sandbox5205f6b7fad54ca19c10a00589e06ef1.mailgun.org"], mail.from
    assert_match user.reset_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
  end

end
