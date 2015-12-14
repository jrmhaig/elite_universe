require 'spec_helper'
require 'elite_universe/planet'

describe EliteUniverse::Planet do
  let(:planet) { EliteUniverse::Planet.new(44344, 5276, 5405) }

  describe '#name' do
    it 'gets the right name' do
      expect(planet.name).to eq 'Lave'
    end

    it 'gets the right name twice' do
      planet.name
      expect(planet.name).to eq 'Lave'
    end
  end

  describe '#next' do
    it 'generates a planet' do
      expect(planet.next).to be_an EliteUniverse::Planet
    end

    it 'finds the next planet' do
      expect(planet.next.name).to eq 'Zaatxe'
    end

    it 'does not affect the current planet' do
      planet.next
      expect(planet.name).to eq 'Lave'
    end
  end
end
