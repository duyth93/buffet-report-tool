class ReportTemplatesController < ApplicationController
  before_action :load_report_template, only: [:destroy, :update]

  def show
    @template = ReportTemplate.find params[:id]
    render json: {
      template: @template.is_default? ? @template.deep_clone : @template
    }
  end

  def create
    @template = current_user.report_templates.build report_template_params.merge(is_default: false)
    @status = @template.save
    render_result
  end

  def update
    @template.assign_attributes report_template_params
    @status = @template.save
    render_result
  end

  def destroy
    @status = @template.destroy
    render_result
  end

  private

  def report_template_params
    params.require(:report_template).permit(:name, :content)
  end

  def render_result
    render json: {
      status: @status,
      template: @template,
      templates: ReportTemplate.default.or(current_user.report_templates)
        .select(:name, :id, :is_default)
    }
  end

  def load_report_template
    @template = current_user.report_templates.find params[:id]
  end
end
