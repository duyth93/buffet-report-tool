class ReportsController < ApplicationController
  before_action :get_chatwork_api, only: [:create, :new]

  def index
  end

  def create
    @report = current_user.reports.build(report_params)
    @report.chatwork_api = @chatwork_api
    @report.save!
    ChatWork.api_key = @report.chatwork_api.api
    ChatWork::Message.create(room_id: @report.room.chatwork_room_id,
                             body: build_body(@report))
    redirect_to root_url
  end

  def new
    last_report = current_user.reports.last
  	@report = last_report.present? ? last_report.deep_clone(include: :report_details)
 : Report.new
    3.times { @report.report_details.build } if last_report.nil?
    @rooms = current_user.rooms.order(id: :desc)
  end

  private

  def report_params
    params.require(:report).permit(:problems, :next_day_plan, :free_comment, :room_id,
      report_details_attributes: [:task, :actual, :percent])
  end

  def get_chatwork_api
    @chatwork_api = current_user.chatwork_apis.order(id: :desc).first
  end

  def build_body(report)
    today_tasks = actual = ""
    report.report_details.each_with_index do |detail, index|
      today_tasks += "- #000#{index + 1}: #{detail.task}\n"
      actual += "- #000#{index + 1}: #{detail.percent}% (#{detail.actual})\n"
    end
    "
[To:637950] Nguyen Van Tan
◆ Today tasks
#{today_tasks}
◆ Actual
#{actual}
◆ Problems and Issues
#{@report.problems}
◆ Next day plan
#{@report.next_day_plan}
◆ Free Comment
#{@report.free_comment}
    "
  end
end
