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
      track_length_seconds = (params[:hours].to_i * 3600) + (params[:mins].to_i * 60)
      all_tracks = build_playlist_number(selected_playlists)
      if number_tracks.to_i > 0
        playlist = all_tracks.sample(number_tracks.to_i)
      elsif track_length_seconds > 0
        random = (0..(all_tracks.length - 1)).to_a.shuffle
        playlist = []
        length = []
        loop do
          n = random.pop
          playlist << all_tracks[n]
          duration = all_tracks[n].duration_ms
          length << (duration / 1000)
          if length.sum >= track_length_seconds || random.length == 0
            break
          end
        end
        raise
      end
      playlist.each do |song|
        add = play(song.id)
        raise
        @list_added << [song.name, add]
      end
    end
  end

  def build_playlist_number(selected_playlists)
    RSpotify.authenticate(ENV["SPOTIFY_KEY_ID"], ENV["SECRET_KEY"])
    tracks = []
    selected_playlists.each do |playlist|
      list = RSpotify::Playlist.find_by_id(playlist)
      list.tracks.each do |track|
        tracks << track
      end
    end
    return tracks
  end
end

