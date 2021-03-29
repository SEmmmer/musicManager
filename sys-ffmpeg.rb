# frozen_string_literal: true

# Trough +ffmpeg+ in system, get song's information
# If cannot get information, the function return nil
# Params:
# +pwd+::The music path

class Music
  def initialize(pwd, name)
    @pwd = pwd + "/"
    @name = name
    @fullpath = @pwd +"\'" + name + "\'"
  end

  def ffmpeg
    info = `ffmpeg -i #{@fullpath} 2>&1`
    info.split('Metadata', 2)[1]
  end

  def artist
    info = ffmpeg
    if info
      info.each_line do |line|
        return line.split(':', 2)[1].strip if line.downcase.include? 'artist'
      end
    end
    'unknown'
  end

  def title
    info = ffmpeg
    if info
      info.each_line do |line|
        if line.downcase.include?('title') || line.downcase.include?('name')
          return line.split(':', 2)[1].strip
        end
      end
    end
    'no_title'
  end

  def album
    info = ffmpeg
    if info
      info.each_line do |line|
        return line.split(':', 2)[1].strip if line.downcase.include? 'album'
      end
    end
    'unknown'
  end

  def is_cover
    title.downcase.include?('cover') || title.include?('翻自')
  end

  def is_mix
    title.downcase.include?(' mix') || title.downcase.include?('mix ') || title.downcase.include?('remix')
  end

  def is_inst
    title.downcase.include?('inst')
  end

  protected :ffmpeg
end