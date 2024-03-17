require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      author = Author.create(name: "John Doe")
      book = Book.new(title: "A Great Book", author: author, year_of_publication: 2020)
      expect(book).to be_valid
    end

    it 'is valid without an author' do
      book = Book.new(title: 'Some Title', author: nil)
      expect(book).to be_valid
    end

    it 'is not valid without a title' do
      book = Book.new(title: nil)
      expect(book).not_to be_valid
      expect(book.errors.messages[:title]).to include("can't be blank")
    end
  end
end
