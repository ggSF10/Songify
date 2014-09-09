require_relative '../lib/songify.rb'
require_relative 'spec_helper.rb'

describe Songify::Songs do
	let(:song) {Songify::Song.new("abc", "xyz")}
		describe "#initialize" do
			it "creates a new instance of a song" do
    	expect(song.artist).to eq("abc")  
    	expect(song.title).to eq("xyz")  
    	expect(song.id).to eq(nil)
		end
	end
end