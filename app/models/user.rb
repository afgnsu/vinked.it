class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable, :confirmable

  has_many :vinks
  has_many :clubs, through: :vinks

  validates :first_name, :last_name, :screen_name, :email, :role, :locale, :subscription, presence: true
  validates :first_name, :last_name, :location, length: { maximum: 50 }
  validates :screen_name, length: { maximum: 15 }
  validates :password, length: { minimum: 8 }, on: :create

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
    return true if subscription == "basic"
    false
  end

  def premium?
    return true if subscription == "premium"
    false
  end

end
