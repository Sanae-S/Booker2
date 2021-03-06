class BooksController < ApplicationController

before_action :authenticate_user!
before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @book_new = Book.new
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def set_book
    @book = current_user.book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book_new = Book.new
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      flash[:notice]="Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
       flash[:notice]="You have updated book successfully."
      redirect_to book_path(@book)
    else

      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    @book.user_id = current_user.id
    if book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def correct_user
    @book = Book.find(params[:id])
    if current_user != @book.user
       redirect_to books_path
    end
  end
end
