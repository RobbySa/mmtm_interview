class BooksController < ApplicationController
  def index
    @books = Book.includes(:authors, :series).all

    @rows = @books.map do |book|
      {
        title: book.name,
        authors: book.authors.map(&:name).join('; '),
        isbn13: book.isbn13,
        publication_year: book.publication_year,
        series_name: book.series_name,
        series_position: book.position,
        pages: book.pages,
        price_pence: book.price_pence,
        currency: book.currency,
        tags: book.tags
      }
    end
  end

  def show
    @book = Book.includes(:authors, :series).find(params[:id])
  end
end
