module ReportHelper
  def render_report_detail_template(f)
    new_object = f.object.class.reflect_on_association(:report_details).klass.new
    f.fields_for(:report_details, new_object, child_index: "new_report_details") do |builder|
      render("report_detail_form", ff: builder)
    end
  end
end
