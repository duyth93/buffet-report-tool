class Report < ApplicationRecord
  belongs_to :report_template
  belongs_to :user
  has_many :report_details
  accepts_nested_attributes_for :report_details,
    reject_if: proc { |attr| attr[:task].blank? || attr[:percent].blank? }
  attr_accessor :to_name, :from_name

  serialize :to_id, Array

  def send_chatwork_msg
    self.user.refresh_token_if_expired
    binding.pry
    ChatWork::Message.create(room_id: self.room_id,
                             body: build_body)
  end

  def build_body
    result = ""
    result = "REPORTER: [To:#{self.from_id}] #{self.from_name}" if self.from_id
    result << generate_list_to if self.to_id && self.to_id.length > 0
    result << self.report_template.content
    result.gsub!(/{{problems}}/, self.problems.to_s)
    result.gsub!(/{{next_day_plan}}/, self.next_day_plan.to_s)
    result.gsub!(/{{free_comment}}/, self.free_comment.to_s)
    result.gsub!(/{{today}}/, Time.now.strftime('%d/%m/%Y'))
    task_details_templates = result.scan(/(?<=({{task-list}}))([\d\D]*?)(?=({{\/task-list}}))/).map do |res|
      res[1]
    end
    task_details_templates.each do |template|
      rendered_report_details = report_details.map.with_index(1) do |details, index|
        temp = template.clone.sub(/\n/, '')
        temp.gsub!(/{{percent}}/, details.percent.to_s)
        temp.gsub!(/{{actual}}/, details.actual)
        temp.gsub!(/{{task}}/, details.task)
        temp.gsub!(/{{index}}/, index.to_s.rjust(4, "0"))
        temp
      end.join('')
      result.sub!(/{{task-list}}[\d\D]*?{{\/task-list}}/, rendered_report_details)
    end
    result
  end

  def generate_list_to
    res = ""
    self.to_id.each_with_index do |id, index|
      res << "\n[To:#{id}] #{self.to_name.present? ? self.to_name[index] : ''}"
    end
    res
  end
end
