require 'json'

class Playlist < ApplicationRecord
  belongs_to :user

  def self.queue(song, token)
    url = "https://api.spotify.com/v1/me/player/queue?uri=spotify%3Atrack%3A#{song}"
    headers = {
      "Authorization" => "Bearer #{token}",
      "Content-Type" => "application/json"
    }
    return HTTParty.post(url, headers: headers)
  end

  def self.top_artists(token, term)
    url = "https://api.spotify.com/v1/me/top/artists?time_range=#{term}&limit=50"
    headers = {
      "Authorization" => "Bearer #{token}",
      "Content-Type" => "application/json",
      "Host" => "api.spotify.com"
    }
    return HTTParty.get(url, headers: headers)
  end

  def self.top_tracks(token, term)
    url = "https://api.spotify.com/v1/me/top/tracks?time_range=#{term}&limit=50"
    headers = {
      "Authorization" => "Bearer #{token}",
      "Content-Type" => "application/json",
      "Host" => "api.spotify.com"
    }
    return HTTParty.get(url, headers: headers)
  end
end
