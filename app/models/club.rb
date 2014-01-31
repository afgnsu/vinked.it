class Club < ActiveRecord::Base
  has_many :vinks
  validates :name, presence: true
end
