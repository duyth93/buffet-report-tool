class ChatworkApisController < ApplicationController
  def room_members
    render json: {
      data: current_user.list_room_members(params[:room_id])
    }
  end
end
