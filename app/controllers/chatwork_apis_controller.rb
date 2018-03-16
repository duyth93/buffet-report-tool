class ChatworkApisController < ApplicationController
  def new
    @chatwork_api = ChatworkApi.new
  end

  def create
    @chatwork_api = current_user.chatwork_apis.build(chatwork_api_params)
    @chatwork_api.save!
    redirect_to new_reports_path
  end

  private

  def chatwork_api_params
    params.require(:chatwork_api).permit(:api)
  end
end
