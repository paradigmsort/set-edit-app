FactoryGirl.define do
  factory :card do
    sequence(:name)  { |n| "Squire #{n}" }
    cost "1W"
    typeline "Creature"
    text ""
    power 1
    toughness 2
  end
end