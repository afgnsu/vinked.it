class User < ActiveRecord::Base
  #has_many :visits

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable, :confirmable

  validates :first_name, :last_name, :email, :role, :locale, :subscription, presence: true
  validates :first_name, :last_name, length: { maximum: 50 }
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
