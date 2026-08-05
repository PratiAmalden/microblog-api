FactoryBot.define do
  factory :comment do
    body { "Test comment" }
    user
    post
  end
end
