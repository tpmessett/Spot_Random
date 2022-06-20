class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def play(songid)
    @time = Time.now.to_i
    RSpotify.authenticate(ENV["SPOTIFY_KEY_ID"], ENV["SECRET_KEY"])
    if current_user.expiry < @time
      User.token_refresh(current_user)
    end
    @result = Playlist.queue(songid, current_user.token)
  end

end
