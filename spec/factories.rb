FactoryGirl.define do
  factory :card do
    sequence(:name)  { |n| "Squire #{n}" }
    cost "1W"
    typeline "Creature"
    text ""
    power_toughness "1/2"
  end
end