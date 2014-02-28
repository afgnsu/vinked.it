class Club < ActiveRecord::Base
  belongs_to :country
  has_many :vinks
  has_many :users, through: :vinks
  has_many :comments, as: :commentable

  validates :name, :country_id, presence: true
  validates :name, uniqueness: true, case_sensitive: false

  scope :starts_with, -> (letter) { where("name LIKE ?", letter + "%") }

  def last_vink
    unless self.vinks.blank?
      self.vinks.order("vink_date ASC").last
    end
  end
end
