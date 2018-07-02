class ReportTemplate < ApplicationRecord
  belongs_to :user, optional: true
  scope :default, ->{where is_default: true}
end
