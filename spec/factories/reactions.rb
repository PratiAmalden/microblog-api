FactoryBot.define do
  factory :reaction do
    user
    association :likable, factory: :micropost

    trait :like do
      kind { :like }
    end

    trait :dislike do
      kind { :dislike }
    end
  end
end
