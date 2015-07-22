require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  # flash[:alert] signifies update failure, flash[:notice] signifies success

  def setup
    @user = users(:alice)
    @other_user = users(:bob)
  end

  test "unsuccessful edit" do
    log_in_as @user
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: {
      password: 'foo',
      password_confirmation: 'bar'
    }
    assert_redirected_to edit_user_path(@user)
    assert_nil flash[:notice]
    assert_not_nil flash[:alert]
  end

  test "successful edit" do
    log_in_as @user
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: {
      bio: 'foobar'
    }
    assert_redirected_to edit_user_path(@user)
    assert_nil flash[:alert]
    assert_not_nil flash[:notice]
  end

  test "user must be logged in to edit" do
    get edit_user_path(@user)
    assert_redirected_to login_path
  end

  test "user can only edit their own profile" do
    log_in_as @user
    assert_raise ActionController::RoutingError do
      get edit_user_path(@other_user)
    end
  end

end
