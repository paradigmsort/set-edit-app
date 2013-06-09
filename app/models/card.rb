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
require 'net/http'

class Card < ActiveRecord::Base
  attr_accessible :name, :cost, :typeline, :text, :power_toughness
  attr_writer :power_toughness

  validates :name, presence: true
  VALID_COST_REGEX = /\A\d*(W|U|B|R|G)*\z/
  validates :cost, format: { with: VALID_COST_REGEX }
  validates :typeline, presence: true
  validates :power, presence: true, unless: "toughness.nil?"
  validates :toughness, presence: true, unless: "power.nil?"
  validate :check_power_toughness

  before_save :save_power_toughness
  after_save :create_image

  def power_toughness
    @power_toughness || (power.to_s + '/' + toughness.to_s unless power.nil? or toughness.nil?)
  end

  def image_url
    ENV['cloud_image_store'] + "/card_#{id}.jpg"
  end

  private
    POWER_TOUGHNESS_REGEX = /\A(\d+)\/(\d+)\z/
    def check_power_toughness
      if @power_toughness.present? && @power_toughness.match(POWER_TOUGHNESS_REGEX).nil?
        errors.add :power_toughness, "cannot be parsed"
      end
    end

    def save_power_toughness
      unless @power_toughness.nil?
        if power_toughness.blank?
          self.power = self.toughness = nil
        else
          @power_toughness.match(POWER_TOUGHNESS_REGEX) do |match|
            self.power = match.captures.first
            self.toughness = match.captures.second
          end
        end
      end
    end

    def image_post_string
      {id: id, name: name, cost: cost, typeline: typeline, text: text, power: power, toughness: toughness}.to_query
    end

    def create_image
      Net::HTTP.start(ENV['cloud_image_builder_url'], ENV['cloud_image_builder_port']) do |http|
        http.post('/images', image_post_string)
      end
    end
end
