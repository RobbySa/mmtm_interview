# THIS FILE IS OUTSIDE THE 3 HOUR LIMIT

RSpec.describe FileValidator, type: :interactor do
  describe '.call' do
    let(data) { {} }

    subject(:result) { described_class(data).call }

    # tech-debt: Test for correct data with good data
    # tech-debt: Test for names missing
    # tech-debt: Test for authors missing
    # tech-debt: Test for duplicates / missing isbn13
    # tech-debt: Test for missing position or series name NOT BOTH only either

    # tech-debt: This is where we would add tests for custom errors
    #            e.g. "Duplicate isbn13 on line 32"
  end
end
