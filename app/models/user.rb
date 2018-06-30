class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(chatwork)
  has_many :chatwork_apis
  has_many :rooms
  has_many :reports

  def self.find_for_oauth(auth)
    user = User.find_by(email: auth.info.email)
    if user
      user = User.update_attributes(
                         access_token: auth.credentials.token,
                         refresh_token: auth.credentials.refresh_token,
                         expired_at: Time.at(auth.credentials.expires_at))
    else
      user = User.create(email:    auth.info.email,
                         provider: auth.provider,
                         uid:      auth.uid,
                         access_token: auth.credentials.token,
                         refresh_token: auth.credentials.refresh_token,
                         expired_at: Time.at(auth.credentials.expires_at),
                         password: Devise.friendly_token[0, 20])
    end
    user
  end
end
