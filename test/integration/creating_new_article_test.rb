require 'test_helper'

class CreatingNewArticleTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end

  test "get new form and create article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: {title: "titleeeee", description: "descriptioooon"}}
    end
    follow_redirect!
    assert_template 'articles/show'
    assert_match "Title", response.body
  end
end
