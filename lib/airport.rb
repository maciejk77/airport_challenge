class Airport

  attr_reader :planes, :capacity

  def initialize
    @planes = []
    @capacity = 20
  end

  def land(plane)
    fail "Cannot land, there is a storm" if stormy?
    raise "Airport full" if full?
    plane.land!
    planes << plane
  end

  def take_off(plane)
    raise "There is a storm" if stormy?
    plane.take_off
    @planes.delete(plane)
  end

  def full?
    planes.count == capacity
  end

  def weather
  end

  def stormy?
    weather == "Stormy"
  end
end
