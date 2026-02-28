FactoryBot.define do
  factory :micropost do
    title { "Test micropost title" }
    body { "Test micropost body" }
    user

    trait :with_comments do 
      after(:create) do |post|
        create_list(:comment, 3, micropost: post)
      end
    end
  end
end
