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
      allow(airport).to receive(:weather).and_return "Sunny"
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

    before {
      allow(airport).to receive(:weather).and_return "Sunny"
    }

    it 'can have a capacity' do
      expect(airport.capacity).to eq(20)
    end

    it 'a plane cannot land if the airport is full' do
      allow(plane).to receive :land!
      airport.capacity.times { airport.land(plane) }
      expect { airport.land(plane) }.to raise_error "Airport full" 
    end

    context 'weather conditions' do
      it 'a plane cannot take off when there is a storm brewing' do
        allow(plane).to receive :land!
        allow(airport).to receive(:weather).and_return "Sunny"
        airport.land(plane)
        allow(airport).to receive(:weather).and_return "Stormy"
        expect{ airport.take_off(plane)}.to raise_error "Cannot take_off, there is a storm"
      end

      it 'a plane cannot land in the middle of a storm' do
        allow(airport).to receive(:weather).and_return "Stormy"
        expect { airport.land(plane) }.to raise_error "Cannot land, there is a storm"
      end
    end
  end
end
