class ChatworkApi < ApplicationRecord
  belongs_to :user, optional: true
  has_many :reports

  def list_room
    ChatWork.api_key = self.api
    result = ChatWork::Room.get
    result.select{|room| room[:type] == 'group'} if result
  end
end
