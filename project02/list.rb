require_relative 'album'

class List
    def initialize(filename)
        @albums = []
        importFile( filename )
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

    attr_reader( :albums )

end

#rock = List.new( "top_100_albums.txt" )
#rock.albums.each { |album| puts "Album: #{album.name} \nYear: #{album.year}\nRank: #{album.rank} \n\n" }
