class Company < ApplicationRecord
  has_many :projects
  has_many :users, dependent: :destroy
  has_many :employees, through: :users
  default_scope -> { order(name: :asc) }
  
  validates :name,            presence: true, 
                              uniqueness: true, 
                              length: { maximum: 100 }
  validates :address1,        length: { maximum: 100 }
  validates :address2,        length: { maximum: 100 }
  validates :city,            length: { maximum: 50 }
  validates :post_code,       length: { maximum: 20 }
  validates :country,         length: { maximum: 50 }
  validates :email,           length: { maximum: 255 },
                              format: { with: VALID_EMAIL_REGEX }
  validates :contact_number,  length: { maximum: 25 }
end
