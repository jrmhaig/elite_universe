# frozen_string_literal: true

require 'spec_helper'
require 'elite_universe/planet'

describe EliteUniverse::Planet do
  let(:tibedied) { described_class.new(23_114, 584, 46_931) }
  let(:lave) { described_class.new(44_344, 5276, 5405) }

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
      expect(lave.next).to be_a described_class
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
    let(:feudal) { described_class.new(23_114, 584, 46_931) }
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
    let(:poor_industrial) { described_class.new(23_114, 584, 46_931) }
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
  end

  describe '#location' do
    subject { planet.location }

    context 'with tibedied' do
      let(:planet) { tibedied }

      it { is_expected.to eq [2, 90] }
    end

    context 'with the planet one on from tibedied' do
      let(:planet) { tibedied.next }

      it { is_expected.to eq [152, 205] }
    end

    context 'with the planet two on from tibedied' do
      let(:planet) { tibedied.next.next }

      it { is_expected.to eq [77, 243] }
    end

    context 'with the planet three on from tibedied' do
      let(:planet) { tibedied.next.next.next }

      it { is_expected.to eq [83, 208] }
    end

    context 'with lave' do
      let(:planet) { lave }

      it { is_expected.to eq [20, 173] }
    end
  end

  describe '#technology' do
    it 'finds that Lave has technology level 5' do
      expect(lave.technology).to eq 5
    end

    it 'finds that Tibedied has technology level 9' do
      expect(tibedied.technology).to eq 9
    end
  end
end
