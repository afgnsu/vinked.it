class League < ActiveRecord::Base
  belongs_to :country
  validates :name, :country_id, presence: true
end
