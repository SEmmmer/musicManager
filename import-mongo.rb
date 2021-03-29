require 'find'
require 'sqlite3'
require_relative 'sys-ffmpeg'
require_relative 'brain-ffmpeg'
require_relative 'exceptions'

sqlite_database = SQLite3::Database.new './local_music_list.db'
rows = sqlite_database.execute <<-SQL
  create table if not exists music (
    title TEXT ,
    artist TEXT,    
    album TEXT ,
    pwd TEXT,
    is_cover INTEGER ,
    is_inst INTEGER ,
    is_mix INTEGER 
  );
SQL

music_dir = '/Users/kiva/Music/Music/Media.localized/Apple Music'
Find.find(music_dir) do |file_path|

  music_path = file_path unless File.directory?(file_path)
  next if (not music_path or music_path.include?('DS_Store'))
  name = music_path.reverse.split('/', 2)[0].reverse
  path = music_path.reverse.split('/', 2)[1].reverse
  music = Music.new(path, name)
  begin
    sqlite_database.execute("insert into music values (?,?,?,?,?,?,?)", [
      music.title,
      music.artist,
      music.album,
      music_path,
      music.is_cover,
      music.is_inst,
      music.is_mix
    ])
  rescue NoTitle
    puts 'this music have no meta-data in its tag'
  rescue NoArtist
    puts 'this music have no meta-data in its tag'
  rescue NoAlbum
    puts 'this music have no meta-data in its tag'

  end
end
