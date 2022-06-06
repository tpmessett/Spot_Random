require 'date'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
     :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, :omniauth_providers => [:spotify]

  def self.from_omniauth(auth)
    # where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.provider = auth.provider
    user.token = auth.credentials.token
    user.refresh_token = auth.credentials.refresh_token
    user.expiry = auth.credentials.expires_at
    user.uid = auth.uid
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.save
    user
  end


  def self.token_refresh(user)
    url = "https://accounts.spotify.com/api/token"
    encoded = Base64.strict_encode64(ENV["SPOTIFY_KEY_ID"] + ':' + ENV["SECRET_KEY"])
    result = HTTParty.post(
    url,
    body: { grant_type: "refresh_token", refresh_token: "#{user.refresh_token}" },
    headers: { "Authorization" => "Basic #{encoded}" }
    )
    @user = User.find(user.id)
    @user.token = result.parsed_response["access_token"]
    @user.expiry = result.parsed_response["expires_in"] + @user.expiry
    @user.save
  end

end


