require 'rspotify'

class PagesController < ApplicationController
  def home
    RSpotify.authenticate(ENV["SPOTIFY_KEY_ID"], ENV["SECRET_KEY"])
    @user = current_user
    @me = RSpotify::User.find(@user.uid)
    @playlists = @me.playlists(limit: 50, offset: 0)
    @user_playlists = Playlist.where(user: current_user)
    if @playlists.length.positive?
      @playlists.each do |playlist|
        if @user_playlists.any?{ |a| a.listid == playlist.id }
          the_playlist = @user_playlists.select{ |a| a.listid == playlist.id }
          edit_playlist = the_playlist[0]
          edit_playlist.update(name: playlist.name)
        else
          new_playlist = Playlist.new
          new_playlist.name = playlist.name
          new_playlist.user_id = current_user.id
          new_playlist.listid = playlist.id
          new_playlist.save
        end
      end
    end
    @updated_playlists = Playlist.where(user: current_user)
  end
end
