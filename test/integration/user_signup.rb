require 'test_helper'

class UserSignup < ActionDispatch::IntegrationTest

	test "create new user" do
		get signup_path
		assert_template 'users/new'
		assert_difference 'User.count', 1 do
			post_via_redirect users_path, user: {username: "testme", email: "test@test.com", password: "test", admin: false}
		end
		assert_template 'users/show'
		assert_match "testme", response.body
	end

end
