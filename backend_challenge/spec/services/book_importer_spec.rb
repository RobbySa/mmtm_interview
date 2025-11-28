# THIS FILE IS OUTSIDE THE 3 HOUR LIMIT

RSpec.describe BookImporter, type: :interactor do
  describe '.call' do
    let(data) { {} }

    subject(:result) { described_class(data).call }

    # tech-debt: Test for correct behaviour with good data
    # tech-debt: Test for not creating duplicate authors already present in DB
    # tech-debt: Test for data non-persistence if transaction fails
    # tech-debt: Test for smarter error return
  end
end
