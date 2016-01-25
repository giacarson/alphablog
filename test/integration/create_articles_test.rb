require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest

	def setup
		@user = User.create(username: "john", email: "test@test.com", password: "password", admin: true)
	end

	test "get new article and create" do
		sign_in_as(@user, "password")
		get new_article_path
		assert_template 'articles/new'
		assert_difference 'Article.count', 1 do
			post_via_redirect articles_path, article: {title: "this is a test title", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam non libero vel dolor hendrerit tristique et sit amet erat. Sed mollis, massa et euismod hendrerit, orci erat faucibus lectus, eu semper metus sapien sit amet ipsum. Proin id elementum ligula. Mauris quis consectetur arcu, eu venenatis massa. Aliquam viverra sem nec ligula scelerisque scelerisque. Interdum et malesuada fames ac ante ipsum primis in faucibus. Curabitur viverra placerat elementum. Nulla facilisi. Maecenas non metus aliquam, hendrerit neque et, dictum orci. Donec non magna et enim pellentesque pharetra. Proin felis orci, viverra a odio a, ultrices porttitor odio. Cras lacinia justo quis posuere tempus. Etiam suscipit, libero mollis dictum venenatis, orci dolor dictum turpis, nec ullamcorper ante nisi ut felis."}
		end
		assert_template 'articles/show'
		assert_match "this is a test title", response.body
	end
end
