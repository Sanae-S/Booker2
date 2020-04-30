class UsersController < ApplicationController
before_action :authenticate_user!
before_action :current_user?, only: [:edit, :update]

  def index
    @users = User.all

    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
  end
  def update
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
    else
      render :edit
    end
  end

  private
  def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def current_user?
     @user = User.find(params[:id])
     if @user != current_user
      redirect_to user_path(current_user)
    end
  end

end
