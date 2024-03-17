require 'rails_helper'

RSpec.describe Author, type: :model do
  # Validation tests
  describe 'validations' do
    it 'is valid with a name' do
      author = Author.new(name: 'J.K. Rowling')
      expect(author).to be_valid
    end

    it 'is invalid without a name' do
      author = Author.new(name: nil)
      expect(author).not_to be_valid
    end
  end
end
