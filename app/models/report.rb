class Report < ApplicationRecord
  belongs_to :chatwork_api, optional: true
  belongs_to :template
  has_many :report_details
  accepts_nested_attributes_for :report_details,
    reject_if: proc { |attr| attr[:task].blank? || attr[:percent].blank? }

  def send_chatwork_msg chatwork_api
    ChatWork.api_key = chatwork_api
    ChatWork::Message.create(room_id: self.room_id,
                             body: build_body)
  end

  def build_body
    result = self.template.content
    result.gsub!(/{{problems}}/, self.problems)
    result.gsub!(/{{next_day_plan}}/, self.next_day_plan)
    result.gsub!(/{{free_comment}}/, self.free_comment)
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
end
