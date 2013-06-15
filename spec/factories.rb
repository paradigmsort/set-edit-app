FactoryGirl.define do
  factory :card do
    sequence(:name)  { |n| "Squire #{n}" }
    cost "1W"
    typeline "Creature"
    text ""
    power 1
    toughness 2
  end

  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    password '123456789'
    password_confirmation '123456789'
  end

  factory :comment do
    sequence(:content) { |n| "Lorum Ipsum #{n}" }
    user
    card
    card_version { card.version }
  end
end