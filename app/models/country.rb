class Country < ActiveRecord::Base
  validates :country, :country_short, presence: true
end
