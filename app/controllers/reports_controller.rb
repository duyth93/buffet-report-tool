class ReportsController < ApplicationController
  before_action :get_chatwork_api, only: [:create, :new]

  def index
  end

  def create
    respond_to do |format|
      format.json do
        @report = current_user.reports.build(report_params)
        status = @report.save
        @report.send_chatwork_msg @chatwork_api.api
        render json: {
          status: status,
          redirect_path: root_path
        }
      end
    end
  end

  def new
    @last_report = current_user.reports.last
  	@report = @last_report.present? ? @last_report.deep_clone(include: :report_details) : Report.new
    @templates = Template.all
    @rooms = current_user.list_room
  end

  private

  def report_params
    params.require(:report).permit(:problems, :next_day_plan, :free_comment, :room_id, :to_id, :to_name,
      :template_id, report_details_attributes: [:task, :actual, :percent]).merge(user_id: current_user.id)
  end

  def get_chatwork_api
    @chatwork_api = ChatworkApi.first
  end
end
