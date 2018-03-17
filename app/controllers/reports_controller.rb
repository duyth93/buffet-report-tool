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
  	@report = Report.new
    @rooms = current_user.rooms.order(id: :desc)
  end

  private

  def report_params
    params.require(:report).permit(:problems, :next_day_plan, :free_comment, :room_id)
  end

  def get_chatwork_api
    @chatwork_api = current_user.chatwork_apis.order(id: :desc).first
  end

  def build_body(report)
    "
◆ Today tasks
◆ Actual
◆ Problems and Issues
#{@report.problems}
◆ Next day plan
#{@report.next_day_plan}
◆ Free Comment
#{@report.free_comment}
    "
  end
end
