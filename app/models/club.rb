class Club < ActiveRecord::Base
  has_many :vinks
  has_many :users, through: :vinks

  validates :name, presence: true

  def vinked?(user=nil)
    if user == nil
      return true #unless self.vinks.blank?
    else
      return true #unless self.vinks.where(user_id: user.id).blank?
    end
    false
  end
end
