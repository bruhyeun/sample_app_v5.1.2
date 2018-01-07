class Project < ApplicationRecord
  belongs_to :company
  attr_accessor :files
  
  validates :code, presence: true, uniqueness: true
  
  def to_param
    code
  end
end
