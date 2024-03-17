require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'validations' do
    it 'is valid with a valid name' do
      tag = Tag.new(name: 'Fantasy')
      expect(tag).to be_valid
    end

    it 'is invalid without a name' do
      tag = Tag.new(name: nil)
      expect(tag).not_to be_valid
      expect(tag.errors.messages[:name]).to include("can't be blank")
    end
  end
end
