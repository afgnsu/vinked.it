class Vink < ActiveRecord::Base
  belongs_to :user
  belongs_to :club
  has_many :comments, as: :commentable

  geocoded_by :set_address
  after_validation :geocode, on: :update

  validates :vink_date, :user_id, :club_id, :away_club_id, presence: true

  scope :this_week, lambda { where("vink_date >= ? AND vink_date <= ?", 1.week.ago, DateTime.now).order("vink_date DESC") }
  scope :this_month, lambda { where("vink_date >= ? AND vink_date <= ?",  Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).order("vink_date DESC") }

  scope :next_vinks, lambda { |next_vink_nr| where("vink_nr > ?", next_vink_nr).order("vink_nr DESC").last(10) }
  scope :prev_vinks, lambda { |prev_vink_nr| where("vink_nr < ?", prev_vink_nr).order("vink_nr DESC").limit(10) }

  def set_address
    country = self.club.country.country
    "#{street} #{city} #{country}"
  end
end
