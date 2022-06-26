# A Random play queue generator for spotify

## Please note the app requires a Spotify Premium Acct to work.

This app is built in Rails and uses a mix of direct calls to the spotify API with RSpotify (as I had problems making RsSpotify pick up certain playlist types)

The App generates random play queues for spotify and weas built due to 2 frustrations I had with Spotify's random algorithm:

1) Spotify only let's you randomise one playlist at a time
2) Spotify often repeats the same songs in a random queue too often, it's not truly random.

## To install:

Git Clone

Yarn Install

Bundle Install

Rails DB Migrate

Rails S to run in local

## Spotify Setup

To edit / play with the App you will need to setup a spotify developer account and get a spotify_key_id and spotify_secret, the app is set up to run them through a .env file.

## The following fields are needed from Spotify:

these are managed in config/initializers.devise.rb:

'user-top-read user-modify-playback-state playlist-read-collaborative playlist-read-private user-read-private user-read-email user-read-recently-played playlist-read-collaborative streaming user-top-read'

If you wish to add additional functions or edit the app these may also need editing.

