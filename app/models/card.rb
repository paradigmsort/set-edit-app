# == Schema Information
#
# Table name: cards
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  cost       :string(255)
#  type       :string(255)
#  text       :string(255)
#  power      :integer
#  toughness  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Card < ActiveRecord::Base
  attr_accessible :name, :cost, :type, :text, :power, :toughness

  validates :name, presence: true
  VALID_COST_REGEX = /\A\d*(W|U|B|R|G)*\z/
  validates :cost, format: { with: VALID_COST_REGEX }
  validates :type, presence: true
  validates :power, presence: true, unless: "toughness.nil?"
  validates :toughness, presence: true, unless: "power.nil?"
end
