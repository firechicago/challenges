require 'pry'
require 'csv'

class Album
  def initialize(id, title)
    @id = id
    @title = title
    @artists = []
    @tracks = []
  end

  def duration_ms
    result = 0
    @tracks.each do |track|
      result += track.duration_ms.to_i
    end
    result
  end

  def duration_sec
    duration_ms / 1000
  end

  def duration_min
    duration_ms / 60_000
  end

  def summary
    sum = "Name: #{@title}\nArtist(s): #{@artists.join(', ')}"
    sum += "\nDuration (min.): #{duration_min}min #{duration_sec % 60}sec"
    sum += "\nTracks:"
    @tracks.each do |track|
      sum += "\n#{track.track_number} - #{track.title}"
    end
    sum
  end

  def add_artist(artist)
    @artists << artist unless @artists.include?(artist)
    @artists
  end

  def add_track(track)
    @tracks << track unless @tracks.include?(track)
  end

  attr_reader :artists, :tracks, :id, :title
end

class Track
  def initialize(album_id, track_id, title, track_number, duration_ms)
    @album_id = album_id
    @id = track_id
    @title = title
    @track_number = track_number
    @duration_ms = duration_ms
  end

  attr_reader :album_id, :id, :title, :track_number, :duration_ms
end

data = CSV.read('space_jams.csv')

album_ids = {}

data[1..-1].each do |line|
  album_id = line[0]
  track_id = line[1]
  title = line[2]
  track_number = line[3]
  duration_ms = line[4]
  album_name = line[5]
  artists = line[6]
  unless album_ids[album_id]
    album_ids[album_id] = Album.new(album_id, album_name)
  end
  album_ids[album_id].add_track(Track.new(album_id, track_id, title, track_number, duration_ms))
  album_ids[album_id].add_artist(artists)
end

album_ids.values.each do |album|
  puts album.summary
  puts ''
end
