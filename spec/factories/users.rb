FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    name { "Test User" }
    email { generate(:email) }
    password { "secrete123" }
    password_confirmation { "secrete123" }

    trait :with_microposts do
      after(:create) do |user|
        create_list(:micropost, 3, user: user)
      end
    end
  end
end
