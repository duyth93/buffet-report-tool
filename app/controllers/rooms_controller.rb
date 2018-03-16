class RoomsController < ApplicationController
  def create
    @room = current_user.rooms.build(room_params)
    @room.save!
    redirect_to new_reports_path
  end

  def new
    @room = Room.new
  end

  private

  def room_params
    params.require(:room).permit(:name, :chatwork_room_id)
  end
end
