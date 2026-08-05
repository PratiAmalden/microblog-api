FactoryBot.define do
  factory :post do
    title { "Test post title" }
    body { "Test post body" }
    user

    trait :with_comments do 
      after(:create) do |post|
        create_list(:comment, 3, post: post)
      end
    end
  end
end
