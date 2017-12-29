require 'pry'

class Song

  attr_accessor :name
  attr_reader :artist, :genre
  extend Concerns::Findable

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist != nil
    self.genre = genre if genre != nil
  end

  def self.all
    @@all
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    found_song = genre.songs.any? { |t| t.name == @name }
    genre.songs << self if found_song == false
    @genre = genre
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << self
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.new_from_filename(name)
    song_parts = name.split(" - ")
    artist_name = song_parts.first
    song_name = song_parts[1]
    genre_name = song_parts[2].gsub(".mp3", "")

    song = self.find_or_create_by_name(song_name)
    artist = Artist.find_or_create_by_name(artist_name)
    song.artist = artist
    genre = Genre.find_or_create_by_name(genre_name)
    song.genre = genre
    song
  end

  def self.create_from_filename(name)
    song = self.new_from_filename(name)
    song.save
  end
end
