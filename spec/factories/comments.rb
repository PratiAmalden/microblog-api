FactoryBot.define do
  factory :comment do
    body { "Test comment" }
    user
    micropost
  end
end
