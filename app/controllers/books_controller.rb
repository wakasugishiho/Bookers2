class BooksController < ApplicationController

  before_action :authenticate_user!

  def index
    @books = Book.all
    @user = User.find(current_user.id)
    @new_book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(current_user.id)
    @new_book = Book.new
  end

  def new
    @book = Book.new
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:notice] = "You have creatad book successfully."
      redirect_to book_path(@new_book.id)
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render action: :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
  if @book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
  else
    render action: :edit
  end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end



private

  def book_params
    params.require(:book).permit(:title, :body)
  end



end
