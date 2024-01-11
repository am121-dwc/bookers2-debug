class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  def new
    @book = Book.new
  end
  def show
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all
    @book = Book.find(params[book_params]) #--パーシャルに渡す変数--
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      flash.now[:notice] = "error. title and body can't be blank."
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])

  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      flash.now[:notice] = "error. book was not updated."
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :book_id)
  end
  def is_matching_login_user
    user = Book.find(params[:id])
    unless user.user_id == current_user.id
      redirect_to books_path
    end
  end
end
