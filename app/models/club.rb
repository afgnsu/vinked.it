class Club < ActiveRecord::Base
  has_many :vinks
  has_many :users, through: :vinks

  validates :name, presence: true
end
