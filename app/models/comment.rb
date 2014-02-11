class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :user_id, :commentable_id, :commentable_type, :content, presence: true
  validates :content, length: { maximum: 140 }
end
