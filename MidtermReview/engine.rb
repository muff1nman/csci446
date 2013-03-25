
class Engine
  attr_accessor :horsepower, :volume, :cylinder_count

  def initialize
    @noise = "VROOOM"
  end

  def go
    100.times { puts @noise }
  end

  def reverse
    @noise.reverse
  end

  def self.manufacture( string )
    Engine::new
    #new_engine.@noise = "hello"
  end

  def test_noise
    @noise
  end

  def to_s
    @noise
  end

  private 
  def set_noise( noise )
    @noise = noise
  end

end
