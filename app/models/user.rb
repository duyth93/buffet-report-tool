class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :registerable,
         :omniauthable, omniauth_providers: %i(chatwork)
  has_many :chatwork_apis
  has_many :rooms
  has_many :reports

  def self.find_for_oauth(auth)
    user = User.find_by(email: auth.info.email)
    if user
      user.update_attributes(
                         access_token: auth.credentials.token,
                         refresh_token: auth.credentials.refresh_token,
                         expired_at: Time.at(auth.credentials.expires_at))
    else
      user = User.create(email:         auth.info.email,
                         provider:      auth.provider,
                         uid:           auth.uid,
                         access_token:  auth.credentials.token,
                         refresh_token: auth.credentials.refresh_token,
                         expired_at:    Time.at(auth.credentials.expires_at),
                         password:      Devise.friendly_token[0, 20])
    end
    user
  end

  def list_room
    refresh_token_if_expired
    result = ChatWork::Room.get
    return result.select{|room| room[:type] == 'group'} if result
    []
  end

  def list_room_members(room_id)
    refresh_token_if_expired
    ChatWork::Member.get(room_id: room_id)
  end

  def refresh_token_if_expired
    if self.provider == "chatwork"
      if self.expired_at < Time.zone.now
        ChatWork.client_id = "qWxlNPG5qM58d"
        ChatWork.client_secret = "qYOiffkCMdA5APyvr]]C@]=Ua1@V9Pt["
        token = ChatWork::Token.refresh_access_token(self.refresh_token)
        self.update_attributes(access_token: token.access_token, expired_at: Time.now + token.expires_in.to_i)
      end
      ChatWork.access_token = self.access_token
    else
      ChatWork.api_key = "155fb61664cf4752f74b19085dcb36fe"
    end
  end
end
