class FileValidator
  def initialize(books_data)
    @books_data = books_data
  end

  def call
    ### Basic checks
    # Name presence
    name_check = @books_data.map { |book| book[:title].to_s.strip }.all?(&:present?)
    # Author presence
    author_check = @books_data.map { |book| book[:authors].to_s.strip }.all?(&:present?)
    # ISBN13 uniqueness and presence
    isbn13_values = @books_data.map { |book| book[:isbn13].to_s.strip }
    isbn13_check = isbn13_values.all?(&:present?) && (isbn13_values.uniq.size == @books_data.size)
    # If series name or position present, the other must be present as well

    # If errors are found given more time, we should point out what they are and on what line of the csv
    { success: name_check && author_check && isbn13_check }
  end
end