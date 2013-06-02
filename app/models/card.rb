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
  attr_accessible :name, :cost, :typeline, :text
  attr_reader :power_toughness, :power, :toughness

  validates :name, presence: true
  VALID_COST_REGEX = /\A\d*(W|U|B|R|G)*\z/
  validates :cost, format: { with: VALID_COST_REGEX }
  validates :typeline, presence: true
  POWER_TOUGHNESS_REGEX = /\A(\d+)\/(\d+)\z/
  validates :power_toughness, format: { with: POWER_TOUGHNESS_REGEX }, allow_nil: true

  def power_toughness=(new_value)
    @power_toughness = new_value
    if new_value.blank?
      @power = @toughness = nil
      @power_toughness = nil
    elsif match = new_value.match(POWER_TOUGHNESS_REGEX)
      @power = match.captures.first.to_i
      @toughness = match.captures.second.to_i
    end
  end
end
