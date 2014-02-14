class Club < ActiveRecord::Base
  belongs_to :country
  has_many :vinks
  has_many :users, through: :vinks
  has_many :comments, as: :commentable

  validates :name, :country_id, presence: true

  def last_vink
    unless self.vinks.blank?
      self.vinks.order("vink_date ASC").last
    end
  end

  def self.per_letter(letter_params)
    order("name ASC").where("name LIKE ?", letter_params + "%")
  end

  def self.set_alphabet_letters
    ("A".."Z").to_a
  end

  def self.get_clubs(params)
    if params[:letter]
      order("name ASC").where("name LIKE ?", params[:letter] + "%")
    else
      order("name ASC")
    end
  end

end
