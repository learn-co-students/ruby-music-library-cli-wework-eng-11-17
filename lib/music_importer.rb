require "pry"

class MusicImporter

  attr_accessor :path, :files

  def initialize(path)
    @path = path
    @files = files
  end

  def files
    Dir["#{@path}/*.mp3"].collect { |path| path.gsub(/^(.*[\\\/])/, '') }
  end

  def import
    @files.each { |file| Song.create_from_filename(file) }
  end
end
