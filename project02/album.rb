
class Album
    @@rank = 1
    def initialize(title, year, rank=@@rank)
        @title = title
        @year = year
        @rank = rank
    end

    attr_accessor( :title )
    attr_accessor( :year )
    attr_accessor( :rank )

end
