class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Signed up successfully. Welcome to the party!"
      log_in @user
      redirect_to root_path
    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update user_params
      flash.now[:notice] = "Bio updated successfully."
      render 'edit'
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render 'edit'
    end

  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :bio)
    end
end
