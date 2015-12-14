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

  describe '#government' do
    # Tibedied (#0) is Feudal
    let(:feudal) { EliteUniverse::Planet.new(23114, 584, 46931) }
    # Qube (#1) is Corporate
    let(:corporate) { feudal.next }
    # Leleer (#2) is Dictatorship
    let(:dictatorship) { corporate.next }
    # Biarge (#3) is Multi-Government
    let(:multigovernment) { dictatorship.next }
    # Xequerin (#4) is Communist
    let(:communist) { multigovernment.next }
    # Ontimaxe (#13) is the first Democratic
    # (Doesn't bode well for democracy in the galaxy)
    let(:democratic) { communist.next.next.next.next.next.next.next.next.next }
    # Cebetela (#14) is Anarchy
    let(:anarchy) { democratic.next }
    # Rizala (#15) is Confederate
    let(:confederate) { anarchy.next }

    it 'finds an Anarchy government' do
      expect(anarchy.government).to eq 'Anarchy'
    end

    it 'finds an Feudal government' do
      expect(feudal.government).to eq 'Feudal'
    end

    it 'finds an Multi-Government government' do
      expect(multigovernment.government).to eq 'Multi-Government'
    end

    it 'finds an Dictatorship government' do
      expect(dictatorship.government).to eq 'Dictatorship'
    end

    it 'finds an Communist government' do
      expect(communist.government).to eq 'Communist'
    end

    it 'finds an Confederate government' do
      expect(confederate.government).to eq 'Confederate'
    end

    it 'finds an Democratic government' do
      expect(democratic.government).to eq 'Democratic'
    end

    it 'finds an Corporate government' do
      expect(corporate.government).to eq 'Corporate'
    end
  end
end
