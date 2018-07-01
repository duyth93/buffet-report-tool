class ReportsController < ApplicationController
  def create
    respond_to do |format|
      format.json do
        @report = current_user.reports.build(report_params)
        status = @report.save
        @report.send_chatwork_msg
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
    @templates = ReportTemplate.default.or(current_user.report_templates).select(:name, :id, :is_default)
    @rooms = current_user.list_room
    @current_user = current_user
  end

  private

  def report_params
    params.require(:report).permit(:problems, :next_day_plan, :free_comment, :room_id, :to_id, :to_name,
      :from_id, :from_name, :report_template_id, report_details_attributes: [:task, :actual, :percent])
      .merge(user_id: current_user.id)
  end
end
