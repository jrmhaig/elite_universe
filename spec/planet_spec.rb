require 'spec_helper'
require 'elite_universe/planet'

describe EliteUniverse::Planet do
  let(:tibedied) { EliteUniverse::Planet.new(23114, 584, 46931) }
  let(:lave) { EliteUniverse::Planet.new(44344, 5276, 5405) }

  describe '#name' do
    it 'gets the right name' do
      expect(lave.name).to eq 'Lave'
    end

    it 'gets the right name twice' do
      lave.name
      expect(lave.name).to eq 'Lave'
    end
  end

  describe '#next' do
    it 'generates a planet' do
      expect(lave.next).to be_an EliteUniverse::Planet
    end

    it 'finds the next planet' do
      expect(lave.next.name).to eq 'Zaatxe'
    end

    it 'does not affect the current planet' do
      lave.next
      expect(lave.name).to eq 'Lave'
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
    let(:multi_government) { dictatorship.next }
    # Xequerin (#4) is Communist
    let(:communist) { multi_government.next }
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
      expect(multi_government.government).to eq 'Multi-Government'
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

  describe '#economy' do
    # Tibedied (#0) is Poor Industrial
    let(:poor_industrial) { EliteUniverse::Planet.new(23114, 584, 46931) }
    # Qube (#1) is Rich Agricultural
    let(:rich_agricultural) { poor_industrial.next }
    # Leleer (#2) is Mainly Industrial
    let(:mainly_industrial) { rich_agricultural.next }
    # Biarge (#3) is Rich Industrial
    let(:rich_industrial) { mainly_industrial.next }
    # Rabedira (#6) is Average Industrial
    let(:average_industrial) { rich_industrial.next.next.next }
    # Teaatis (#10) is Average Agricultural
    let(:average_agricultural) { average_industrial.next.next.next.next }
    # Ontimaxe (#13) is Mainly Agricultural
    let(:mainly_agricultural) { average_agricultural.next.next.next }
    # Teanrebi (#18) is Poor Agricultural
    let(:poor_agricultural) { mainly_agricultural.next.next.next.next.next }
    # Sotiqu (#21) is Poor Agricultural because it is Anarchy
    let(:poor_agricultural_anarchy) { poor_agricultural.next.next.next }

    it 'finds a Rich Industrial economy' do
      expect(rich_industrial.economy).to eq 'Rich Industrial'
    end

    it 'finds a Average Industrial economy' do
      expect(average_industrial.economy).to eq 'Average Industrial'
    end

    it 'finds a Poor Industrial economy' do
      expect(poor_industrial.economy).to eq 'Poor Industrial'
    end

    it 'finds a Mainly Industrial economy' do
      expect(mainly_industrial.economy).to eq 'Mainly Industrial'
    end

    it 'finds a Rich Agricultural economy' do
      expect(rich_agricultural.economy).to eq 'Rich Agricultural'
    end

    it 'finds a Average Agricultural economy' do
      expect(average_agricultural.economy).to eq 'Average Agricultural'
    end

    it 'finds a Poor Agricultural economy' do
      expect(poor_agricultural.economy).to eq 'Poor Agricultural'
    end

    it 'finds a Mainly Agricultural economy' do
      expect(mainly_agricultural.economy).to eq 'Mainly Agricultural'
    end

    it 'finds economy that is Poor Agricultural because of Anarchy' do
      expect(poor_agricultural_anarchy.economy).to eq 'Poor Agricultural'
    end

    describe '#location' do
      it 'finds the correct location of a planet' do
        expect(tibedied.location).to eq [ 2, 90 ]
        expect(tibedied.next.location).to eq [ 152, 205 ]
        expect(tibedied.next.next.location).to eq [ 77, 243 ]
        expect(tibedied.next.next.next.location).to eq [ 83, 208 ]
        expect(lave.location).to eq [ 20, 173 ]
      end
    end
  end
end
