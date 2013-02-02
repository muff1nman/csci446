require 'sqlite3'

db = SQLite3::Database.new( "albums.sqlite3.db" )
db.execute( "select * from albums" ) do |row|
    row.each { |column_value| print "#{column_value}, " }
    puts ""
end
