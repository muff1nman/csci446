require_relative 'album'
require 'sqlite3'

class List
    attr_reader :albums

    def initialize(filename)
        @albums = []
        #importFile( filename )
        importDatabase( filename )
    end

    def importFile( filename )
        rank = 1
        File.open(filename, "r") do |file|
            file.each do |line| 
                pieces = line.split(',')
                next if pieces.length != 2
                @albums << Album.new( pieces[0].chomp, pieces[1].chomp, rank )
                rank += 1
            end
        end
    end

    def importDatabase( filename )
        SQLite3::Database.open( filename ) do |db|
            db.results_as_hash = true
            stmt_select_all = db.prepare( "SELECT * from albums;")
            stmt_select_all.execute
            stmt_select_all.each do |row|
                @albums << Album.new( row['title'], row['year'], row['rank'] )
            end
        end
        rescue SQLite3::Exception => e
            puts "Issue with Database!"
            puts e
    end

end

#rock = List.new( "top_100_albums.txt" )
#rock.albums.each { |album| puts "Album: #{album.name} \nYear: #{album.year}\nRank: #{album.rank} \n\n" }
