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
    # @artists = Playlist.top_artists(@user.token, "medium_term")
    # @tracks = Playlist.top_tracks(@user.token, "medium_term")
    @user_playlists = Playlist.where(user: current_user)
    @list_added = []
    if params[:hours] != nil || params[:mins] != nil || params[:tracks] != nil
      selected_playlists = params[:selected_playlists]
      number_tracks = params[:tracks]
      track_length_mins = (params[:hours] * 60) + params[:mins]
      if number_tracks.to_i > 0
        all_tracks = build_playlist_number(selected_playlists, number_tracks)
        playlist = []
        loop do
          n = rand(all_tracks.length)
          playlist << all_tracks[n]
          if playlist.length >= number_tracks.to_i
            break
          end
        end
      end
      playlist.each do |song|
        add = play(song[:id])
        @list_added << [song[:name], add]
      end
    end
  end

  def build_playlist_number(selected_playlists, number_tracks)
    RSpotify.authenticate(ENV["SPOTIFY_KEY_ID"], ENV["SECRET_KEY"])
    tracks = []
    selected_playlists.each do |playlist|
      list = RSpotify::Playlist.find_by_id(playlist)
      list.tracks.each do |track|
        tracks << { id: track.id, name: track.name }
      end
    end
    return tracks
  end
end

