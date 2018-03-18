class Report < ApplicationRecord
  belongs_to :chatwork_api
  belongs_to :room
  has_many :report_details
  accepts_nested_attributes_for :report_details,
    reject_if: proc { |attr| attr[:task].blank? || attr[:percent].blank? }
end
