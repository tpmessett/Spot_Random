require 'rspotify'
require 'date'

class PagesController < ApplicationController
  def home
    RSpotify.authenticate(ENV["SPOTIFY_KEY_ID"], ENV["SECRET_KEY"])
    @user = current_user
    @time = Time.now.to_i
    if @user.expiry < @time
      User.token_refresh(current_user)
    end
    @me = RSpotify::User.find(@user.uid)
    @playlists = @me.playlists(limit: 50, offset: 0)
    @artists = Playlist.top_artists(@user.token, "medium_term")
    @tracks = Playlist.top_tracks(@user.token, "short_term")
    @user_playlists = Playlist.where(user: current_user)
    raise
  end
end

