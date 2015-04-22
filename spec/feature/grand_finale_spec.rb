require 'capybara/rspec'
require 'airport'
require 'plane'

## Note these are just some guidelines!
## Feel free to write more tests!!

# Given 6 planes, each plane must land.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have status "landed"
# Once all planes are in the air again, check that they have status "flying!"

feature 'Grand Finale' do
  airport = Airport.new
  plane_1 = Plane.new
  plane_2 = Plane.new
  plane_3 = Plane.new
  plane_4 = Plane.new
  plane_5 = Plane.new
  plane_6 = Plane.new

  scenario 'all planes can land and all planes can take off' do
    airport = Airport.new
    allow(airport).to receive(:weather).and_return "Sunny"
    planes = [Plane.new, Plane.new, Plane.new, Plane.new, Plane.new, Plane.new]
    planes.each {|plane| airport.land(plane)}
    expect(airport.planes).to eq planes
  end
end
