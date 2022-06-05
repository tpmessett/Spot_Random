require 'json'

class Playlist < ApplicationRecord
  belongs_to :user


  def self.queue(song, token)
    url = "https://api.spotify.com/v1/me/player/queue?uri=spotify%3Atrack%3A#{song}"
    headers = {
      "Authorization" => "Bearer #{token}",
      "Content-Type" => "application/json"
    }
    uri = URI.parse(url)
    return HTTParty.post(url, headers: headers)
  end
end
