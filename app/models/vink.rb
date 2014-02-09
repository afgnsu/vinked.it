class Vink < ActiveRecord::Base
  belongs_to :user
  belongs_to :club

  validates :vink_date, :user_id, :club_id, :away_club_id, presence: true

  scope :this_week, lambda { where("vink_date >= ? AND vink_date <= ?", 1.week.ago, DateTime.now).order("vink_date DESC") }
  scope :this_month, lambda { where("vink_date >= ? AND vink_date <= ?",  Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).order("vink_date DESC") }
end
