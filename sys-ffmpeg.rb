# frozen_string_literal: true

# Trough +ffmpeg+ in system, get song's information
# If cannot get information, the function return nil
# Params:
# +pwd+::The music path
#
class Music
  def initialize(pwd)
    @pwd = pwd
  end

  def ffmpeg
    info = `ffmpeg -i #{@pwd} 2>&1`
    info.split('Metadata', 2)[1]
  end

  def artist
    info = ffmpeg
    info.each_line do |line|
      return line.split(':', 2)[1].strip if line.downcase.include? 'artist'
    end
    nil
  end

  def title
    info = ffmpeg
    info.each_line do |line|
      if line.downcase.include?('title') || line.downcase.include?('name')
        return line.split(':', 2)[1].strip
      end
    end
    nil
  end

  def album
    info = ffmpeg
    info.each_line do |line|
      return line.split(':', 2)[1].strip if line.downcase.include? 'album'
    end
    nil
  end

  protected :ffmpeg
end

music1 = Music.new('/Users/emmmer/Downloads/a.m4p')
# music1.ffmpeg
puts music1.artist
puts music1.title
puts music1.album
