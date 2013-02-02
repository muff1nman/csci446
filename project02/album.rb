class Album
    @@rank = 1
    def initialize(name, year, rank=@@rank)
        @name = name
        @year = year
        @rank = rank
    end

    attr_accessor( :name )
    attr_accessor( :year )
    attr_accessor( :rank )

end
