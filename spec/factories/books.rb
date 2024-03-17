FactoryBot.define do
  factory :user, class: Book do
    title { Faker::Book.name }
  end
end