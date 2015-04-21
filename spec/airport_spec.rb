require 'airport'

## Note these are just some guidelines!
## Feel free to write more tests!!

# A plane currently in the airport can be requested to take off.
#
# No more planes can be added to the airport, if it's full.
# It is up to you how many planes can land in the airport
# and how that is implemented.
#
# If the airport is full then no planes can land

describe Airport do

  let(:airport){ Airport.new }
  let(:plane){ double :plane }

  context 'taking off and landing' do

    before do
      allow(plane).to receive :land!
      allow(plane).to receive :take_off
    end

    it 'can land a plane' do
      airport.land(plane)
      expect(airport.planes).to eq [plane]
    end

    it 'lands a plane when landing a plane' do
      expect(plane).to receive(:land!)
      airport.land(plane)
    end

    it 'can take off a plane' do
      airport.land(plane)
      airport.take_off plane
      expect(airport.planes).to be_empty
    end

    it 'takes of the plane when taking off a plane' do
      airport.land(plane)
      expect(plane).to receive :take_off
      airport.take_off(plane)
    end
  

  end

  context 'traffic control' do

    it 'can have a capacity' do
      expect(airport.capacity).to eq(20)
    end

    it 'a plane cannot land if the airport is full' do
      allow(plane).to receive :land!
      airport.capacity.times { airport.land(plane) }
      expect { airport.land(plane) }.to raise_error "Airport full" 
    end


    # Include a weather condition.
    # The weather must be random and only have two states "sunny" or "stormy".
    # Try and take off a plane, but if the weather is stormy,
    # the plane can not take off and must remain in the airport.
    #
    # This will require stubbing to stop the random return of the weather.
    # If the airport has a weather condition of stormy,
    # the plane can not land, and must not be in the airport

    context 'weather conditions' do
      it 'a plane cannot take off when there is a storm brewing' do
        allow(plane).to receive :land!
        airport.land(plane)
        allow(airport).to receive(:weather).and_return "Stormy"
        expect{ airport.take_off(plane)}.to raise_error "There is a storm"
      end

      it 'a plane cannot land in the middle of a storm' do
        allow(airport).to receive(:weather).and_return "Stormy"
        expect { airport.land(plane) }.to raise_error "Cannot land, there is a storm"
      end
    end
  end
end
