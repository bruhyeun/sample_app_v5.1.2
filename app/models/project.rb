class Project < ApplicationRecord
  belongs_to :company
  attr_accessor :files
  
  validates :code, presence: true, uniqueness: true
  
  # This will allow the use of :code as project identifier, instead of :id
  def to_param
    code
  end
end
