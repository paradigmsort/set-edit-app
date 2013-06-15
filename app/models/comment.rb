# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  content      :string(255)
#  user_id      :integer
#  card_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  card_version :integer
#

class Comment < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  belongs_to :card

  validates :user_id, presence: true
  validates :card_id, presence: true
  validates :content, presence: true
  validates :card_version, presence: true

  default_scope order: 'comments.created_at DESC'
end
