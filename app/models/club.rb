class Club < ActiveRecord::Base
  belongs_to :country
  has_many :vinks
  has_many :users, through: :vinks

  validates :name, :country_id, presence: true

  def last_vink
    unless self.vinks.blank?
      self.vinks.order("vink_date ASC").last
    end
  end
end
