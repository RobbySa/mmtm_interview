class BookImporter
  def initialize(books_data)
    @books_data = books_data
  end

  def call
    ActiveRecord::Base.transaction do
      @books_data.each do |book_data|
        puts book_data
        # Given more time this could be done better so that multiple authors don't have to be reloaded each time
        authors = book_data[:authors].split(';').map { |author| Author.find_or_create_by(name: sanitise_field(author)) }
        series = sanitise_field(book_data[:series_name]).present? ? Series.find_or_create_by(name: sanitise_field(book_data[:series_name])) : nil

        # Given more time the isbn13 error would be handled better
        raise ArgumentError if Book.pluck(:isbn13).include? sanitise_field(book_data[:isbn13])

        book = create_book(book_data, series)
        create_relations(book, authors, series, sanitise_field(book_data[:series_position]))
      end
    end
    { success: true }
  rescue StandardError => e
    puts e.inspect
    { success: false }
  end

  private

  def create_book(book_data, series)
    Book.create(
      name: sanitise_field(book_data[:title]),
      pages: sanitise_field(book_data[:pages].to_i),
      isbn13: sanitise_field(book_data[:isbn13]),
      publication_year: sanitise_field(book_data[:publication_year].to_i),
      price_pence: sanitise_field(book_data[:price_pence].to_i),
      currency: sanitise_field(book_data[:currency]),
      tags: sanitise_field(book_data[:tags]),
      series: series,
      position: sanitise_field(book_data[:series_position].to_i)
    )
  end

  def create_relations(book, authors, series, position)
    authors.each { |author| AuthorsBook.create(author: author, book: book) }
  end

  def sanitise_field(field)
    field.to_s.strip
  end
end