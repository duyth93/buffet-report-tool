class Report < ApplicationRecord
  belongs_to :chatwork_api
  belongs_to :room
  has_many :report_details
end
