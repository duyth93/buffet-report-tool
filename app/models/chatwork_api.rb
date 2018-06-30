class ChatworkApi < ApplicationRecord
  belongs_to :user, optional: true
  has_many :reports

  def list_room
    ChatWork.access_token = self.user.access_token
    result = ChatWork::Room.get
    result.select{|room| room[:type] == 'group'} if result
  end
end
