class DataTable < ApplicationRecord
  belongs_to :project
  has_many :data_records, dependent: :destroy
end
