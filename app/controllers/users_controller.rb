class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@new_book = Book.new
  end

  def index
  	@users = User.all
  	@user = User.find(current_user.id)
  	@new_book = Book.new
  end

  def edit
  	@user = User.find(params[:id])
  	if @user != current_user
  	redirect_to user_path(current_user.id)
  	end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  	flash[:notice] = "You have updated user successfully."
  	redirect_to user_path(@user.id)
  	else
  	render action: :edit
  	end
  end



private

  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
