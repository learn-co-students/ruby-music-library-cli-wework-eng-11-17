require "pry"

class MusicLibraryController

  def initialize(path = './db/mp3s')
    music_importer = MusicImporter.new(path)
    music_importer.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    input = gets.chomp
    case input
    when "list songs"
      list_songs
    when "list artists"
      list_artists
    when "list genres"
      list_genres
    when "list artist"
      list_songs_by_artist
    when "list genre"
      list_songs_by_genre
    when "play song"
      play_song
    end
    call unless input == "exit"
  end

  def list_songs
    sorted_songs = Song.all.sort { |x, y| x.name <=> y.name }.uniq
    sorted_songs.each_with_index { |song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    sorted_artists = Artist.all.sort { |x, y| x.name <=> y.name }.uniq
    sorted_artists.each_with_index { |artist, index| puts "#{index + 1}. #{artist.name}"}
  end

  def list_genres
    sorted_genres = Genre.all.sort { |x, y| x.name <=> y.name }.uniq
    sorted_genres.each_with_index { |genre, index| puts "#{index + 1}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_input = gets.chomp
    artist_songs = Song.all.select { |song| song.artist.name == artist_input }.sort { |x, y| x.name <=> y.name }.uniq
    artist_songs.each_with_index { |song, index| puts "#{index + 1}. #{song.name} - #{song.genre.name}" }
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_input = gets.chomp
    genre_songs = Song.all.select { |song| song.genre.name == genre_input }.sort { |x, y| x.name <=> y.name }.uniq
    genre_songs.each_with_index { |song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name}" }
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp.to_i
    sorted_songs = Song.all.sort { |x, y| x.name <=> y.name }.uniq
    return if input < 1 || input > sorted_songs.size
    selected_song = sorted_songs[input.to_i - 1]
    puts "Playing #{selected_song.name} by #{selected_song.artist.name}"
  end
end
