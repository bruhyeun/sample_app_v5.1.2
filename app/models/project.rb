class Project < ApplicationRecord
  belongs_to :company
  
  validates :code, presence: true, unique: true
end
