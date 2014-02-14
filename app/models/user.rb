class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable, :confirmable, :omniauthable

  has_many :vinks, dependent: :destroy
  has_many :clubs, through: :vinks
  has_many :comments, as: :commentable
=begin
  validates :first_name, presence: true if self.provider.blank?
  validates :last_name, presence: true  if last_name_required?
  validates :email, presence: true      if email_required?
  validates :first_name, presence: true if first_name_required?

  validates :screen_name, :role, :locale, :subscription, presence: true
  validates :first_name, :location, length: { maximum: 50 } if first_name_required?
  validates :last_name,  :location, length: { maximum: 50 } if first_name_required?

  before_save { |user| user.email = email.downcase } if email_required?
=end
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

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      puts "IMAGE #{auth.description.profile_image_url}"
      puts "LANG #{auth.description.lang}"
      puts "LOCATION #{auth.description.location}"
      puts "TWITTER #{auth.urls.twitter}"
      user.provider = auth.provider
      user.uid = auth.uid
      user.screen_name = auth.info.nickname
      user.confirmed_at = DateTime.now
      user.subscription = "basic"
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def email_required?
    super && provider.blank?
  end

  def self.first_name_required?
    super && provider.blank?
  end

  def last_name_required?
    super && provider.blank?
  end

end

