class Comment < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  belongs_to :card

  validates :user_id, presence: true
  validates :card_id, presence: true
  validates :content, presence: true

  default_scope order: 'comments.created_at DESC'
end
