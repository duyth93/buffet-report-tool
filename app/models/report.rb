class Report < ApplicationRecord
  belongs_to :chatwork_api_id
  belongs_to :room_id
  has_many :report_details
end
