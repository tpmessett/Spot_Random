require 'rspotify'
require 'date'

class PlaylistsController < ApplicationController
  def show
    RSpotify.authenticate(ENV["SPOTIFY_KEY_ID"], ENV["SECRET_KEY"])
    @user = current_user
    @me = RSpotify::User.find(@user.uid)
    @playlist = Playlist.find(params[:id])
    @playlist_spotify = RSpotify::Playlist.find_by_id(@playlist.listid)
    @playlist_tracks =  @playlist_spotify.tracks
  end

  def play
    @time = Time.now.to_i
    RSpotify.authenticate(ENV["SPOTIFY_KEY_ID"], ENV["SECRET_KEY"])
    songid = params[:songid]
    puts songid
    if current_user.expiry < @time
      User.token_refresh(current_user)
    end
    @result = Playlist.queue(songid, current_user.token)
  end
end
