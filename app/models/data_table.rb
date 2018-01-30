class DataTable < ApplicationRecord
  belongs_to :project
  has_many :data_records, dependent: :destroy
  
  attr_accessor :records_per_page
end
