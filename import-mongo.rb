require 'find'
require_relative 'sys-ffmpeg'
require 'mongo'
require 'sqlite3'

client = Mongo::Client.new(['127.0.0.1:27017'], database: 'MusicManager')
col = client[:AllMusic]

music_dir = '/Users/emmmer/Downloads/test'
Find.find(music_dir) do |file_path|

  music_path = file_path unless File.directory?(file_path)
  next if (not music_path or music_path.include?('DS_Store'))
  name = music_path.reverse.split('/', 2)[0].reverse
  path = music_path.reverse.split('/', 2)[1].reverse
  music = Music.new(path, name)
  puts music.album
  puts music.artist
  puts music.title
  puts path
  puts name

end
