FactoryBot.define do
  factory :user do
    nickname              {"Peter"}
    email                 {"peter@peter.com"}
    password              {"1a1a1a1a"}
    password_confirmation {password}
  end
end