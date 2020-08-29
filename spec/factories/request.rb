FactoryBot.define do
  factory :request do
    request_word  { 'apple' }
    association :user
  end
end