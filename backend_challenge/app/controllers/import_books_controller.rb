class ImportBooksController < ApplicationController
  before_action :authenticate_user!

  # tech-debt: the failures shouldn't be displayed like this
  #            the frontend part should render the notices or alert
  #            in a smart way
  def create
    if params[:file].present?
      file = params[:file]
      options = { headers_in_file: true, strip_whitespace: true }
      books_data = SmarterCSV.process(file.tempfile.path, options)

      # Validate that the data in the file can be imported
      validator_result = FileValidator.new(books_data).call

      if validator_result[:success]
        import_result = BookImporter.new(books_data).call

        # Only redirect if the import was successful
        if import_result[:success]
          puts 'Success'
          redirect_to root_path, notice: 'Books were successfully imported' if import_result[:success]
        else
          puts 'Failure 1'
          redirect_to root_path, alert: 'There has been an error with the books file'
        end
      else
        puts 'Failure 2'
        redirect_to root_path, alert: 'There has been an error with the books file'
      end
    else
      puts 'Failure 3'
      redirect_to root_path, alert: 'There has been a problem importing the books'
    end
  end
end
