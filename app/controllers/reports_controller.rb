class ReportsController < ApplicationController
  def index
  end

  def create
  end

  def new
  	@report = Report.new
    @chatwork_apis = current_user.chatwork_apis.includes(:rooms)
  end
end
