module Songify
  
  class Song
  	attr_reader :artist, :title, :id

  	def initialize(artist, title, id=nil)
      @artist = artist
      @title = title
      @id = id
  	end

  end
end