class DataLog < ApplicationRecord
  belongs_to :project
  belongs_to :vessel
  belongs_to :sensor
end
