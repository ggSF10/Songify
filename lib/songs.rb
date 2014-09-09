require 'pg'

module Songify
  class Songs

    def initialize
      @db = PG.connect(host: 'localhost', dbname: 'songify')
    end

    def create_table
      sql = <<-SQL
      CREATE TABLE IF NOT EXISTS songs(
        id SERIAL PRIMARY KEY,
        artist TEXT,
        title TEXT)
      SQL
      @db.exec(sql)
    end

    def reset_table
      @db.exec("DROP TABLE IF EXISTS songs")
    end

    def save_song(song)
      sql = <<-SQL
        INSERT INTO songs(artist, title)
        VALUES('#{song.artist}', '#{song.title}') returning *
      SQL
      result = @db.exec(sql)
      song.instance_variable_set("@id", result[0]["id"])
    end

    def delete_song(artist, title)
      sql = <<-SQL
        DELETE FROM songs
        WHERE (artist = '#{artist}' AND title = '#{title}')
      SQL
      result = @db.exec(sql).entries
    end

    def find_all
      result = @db.exec("SELECT * FROM songs").entries
      if result == []
        raise "No songs found"
      else
        result.each do |x|
          build_song(result)
        end
      end
    end

    def find_id(id)
      result = @db.exec("SELECT * FROM songs WHERE id = '#{id}'").entries
      if result == []
        raise "No song found"
      else
        build_song(result)
      end
    end

    def find_artist(artist)
      result = @db.exec("SELECT * FROM songs WHERE artist = '#{artist}'").entries
      if result == []
        raise "No song found"
      else
        build_song(result)
      end
    end

    def find_title(title)
      result = @db.exec("SELECT * FROM songs WHERE title = '#{title}'").entries
      if result == []
        raise "No song found"
      else
        build_song(result)
      end
    end

    def build_song(result)
      Songify::Song.new(result[0]["artist"], result[0]["title"], result[0]["id"])
    end

  end
end