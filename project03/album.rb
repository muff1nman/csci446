class Album
    attr_accessor :name, :year, :rank

    @@rank = 1
    def initialize(name, year, rank=@@rank)
        @name = name
        @year = year
        @rank = rank
    end

end
