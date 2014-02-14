class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable, :confirmable

  has_many :vinks, dependent: :destroy
  has_many :clubs, through: :vinks
  has_many :comments, as: :commentable

  validates :first_name, :last_name, :screen_name, :email, :role, :locale, :subscription, presence: true
  validates :first_name, :location, length: { maximum: 50 }
  validates :last_name,  :location, length: { maximum: 50 }

  before_save { |user| user.email = email.downcase }

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def admin?
    return true if role == "admin"
    false
  end

  def user?
    return true if role == "user"
    false
  end

  def basic?
    return true if subscription == "basic" or subscription == "premium"
    false
  end

  def premium?
    return true if subscription == "premium"
    false
  end

end

