require_relative '../lib/songify.rb'
require_relative 'spec_helper.rb'

describe Songify::Songs do
  describe "Songs" do
  	let(:songs) {Songify::Songs.new}
    let(:song) {Songify::Song.new("abc", "xyz")}

    before :each do
      songs.create_table
      songs.save_song(song)
    end

  	after :each do
      songs.reset_table
  	end

    it "save a song and finds all" do
      result = songs.find_all
      expect(result).to be_an(Array)
      expect(result.size).to eq(1)
    end

    it "deletes a song" do
      result = songs.delete_song("abc", "xyz")
      expect(result).to eq([])
    end

    it "returns error if no songs are found" do
      result = songs.find_all
      expect{songs.find_id(2)}.to raise_error("No song found")
    end

    it "returns a song by id" do
      found = songs.find_id(song.id)
      expect(found.id).to eq(song.id)
    end

    it "returns a song by artist" do
     	result = songs.save_song(song)
      found = songs.find_artist(song.artist)
      expect(found.artist).to eq(song.artist)
    end

    it "returns a song by title" do
    	result = songs.save_song(song)
      found = songs.find_title(song.title)
      expect(found.title).to eq(song.title)
    end

  end
end