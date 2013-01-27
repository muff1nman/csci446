require 'erb'

class Form
    def initialize( formLocation )
        @rank = Hash.new
        @order = Hash.new
        if File.readable?( formLocation) 
            @rawForm = File.open( formLocation, "r" ) { |f| f.read }
        else
            @rawForm = "<html>Form Error!</html>"
        end
        @erb = ERB.new( @rawForm )
    end

    def newOrder( value, display )
        @order[value] = display
    end

    def newRank( value, display )
        @rank[value] = display
    end

    def render()
        @erb.result( get_binding )
    end

    def get_binding()
        binding()
    end

    attr_accessor( :defaultOrder )

end
