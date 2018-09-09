require 'airport'

describe Airport do
  let(:weather) { double(:weather, :stormy? => false) }

  it 'feature test allows multiple airports to land and take off planes' do
    allow(weather).to receive(:stormy?).and_return(false)
    heathrow = Airport.new(5, weather)
    stansted = Airport.new(2, weather)
    city = Airport.new(Airport::CAPACITY, weather)
    airbus = Plane.new
    boeing = Plane.new
    bombardier = Plane.new
    cessna = Plane.new
    embraer = Plane.new
    tupoloev = Plane.new
    heathrow.land(airbus)
    heathrow.land(boeing)
    heathrow.land(bombardier)
    heathrow.land(cessna)
    heathrow.land(embraer)
    expect { heathrow.land(tupoloev) }.to raise_error 'Airport full'
    expect { stansted.land(airbus) }.to raise_error 'Plane in another airport'
    heathrow.takeoff(airbus)
    heathrow.takeoff(boeing)
    stansted.land(airbus)
    expect { stansted.land(bombardier) }.to raise_error 'Plane in another airport'
    stansted.land(boeing)
    expect { stansted.land(tupoloev) }.to raise_error 'Airport full'
    stansted.takeoff(airbus)
    expect(airbus.location).to eq('flying')
    city.land(airbus)
    expect(airbus.location).to eq(city.object_id)
    expect { city.land(tupoloev) }.to raise_error 'Airport full'
    city.takeoff(airbus)
  end
end
