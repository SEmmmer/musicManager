# frozen_string_literal: true
require_relative 'sys-ffmpeg'

music = Music.new('/Users/emmmer/Downloads/test', 'dd.flac')
puts music.artist
puts music.album
puts music.title

