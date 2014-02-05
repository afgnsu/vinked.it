class Country < ActiveRecord::Base
  has_many :clubs
  validates :country, :country_short, presence: true
end
