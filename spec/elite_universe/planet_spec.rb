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
    subject { planet.government }

    let(:first_planet) { described_class.new(23_114, 584, 46_931) }

    context 'with an Anarchy government' do
      # Cebetela (#14) is Anarchy
      let(:planet) { 14.times.inject(first_planet) { |p, _| p.next } }

      it { is_expected.to eq 'Anarchy' }
    end

    context 'with a Feudal government' do
      # Tibedied (#0) is Feudal
      let(:planet) { first_planet }

      it { is_expected.to eq 'Feudal' }
    end

    context 'with a Multi-Government government' do
      # Biarge (#3) is Multi-Government
      let(:planet) { 3.times.inject(first_planet) { |p, _| p.next } }

      it { is_expected.to eq 'Multi-Government' }
    end

    context 'with a Dictatorship government' do
      # Leleer (#2) is Dictatorship
      let(:planet) { 2.times.inject(first_planet) { |p, _| p.next } }

      it { is_expected.to eq 'Dictatorship' }
    end

    context 'with a Communist government' do
      # Xequerin (#4) is Communist
      let(:planet) { 4.times.inject(first_planet) { |p, _| p.next } }

      it { is_expected.to eq 'Communist' }
    end

    context 'with a Confederate government' do
      # Rizala (#15) is Confederate
      let(:planet) { 15.times.inject(first_planet) { |p, _| p.next } }

      it { is_expected.to eq 'Confederate' }
    end

    context 'with a Democratic government' do
      # Ontimaxe (#13) is the first Democratic
      # (Doesn't bode well for democracy in the galaxy)
      let(:planet) { 13.times.inject(first_planet) { |p, _| p.next } }

      it { is_expected.to eq 'Democratic' }
    end

    context 'with a Corporate government' do
      # Qube (#1) is Corporate
      let(:planet) { first_planet.next }

      it { is_expected.to eq 'Corporate' }
    end
  end

  describe '#economy' do
    subject { planet.economy }

    let(:first_planet) { described_class.new(23_114, 584, 46_931) }

    context 'with a Rich Industrial economy' do
      # Biarge (#3) is Rich Industrial
      let(:planet) { 3.times.inject(first_planet) { |p, _| p.next } }

      it { is_expected.to eq 'Rich Industrial' }
    end

    context 'with a Average Industrial economy' do
      # Rabedira (#6) is Average Industrial
      let(:planet) { 6.times.inject(first_planet) { |p, _| p.next } }

      it { is_expected.to eq 'Average Industrial' }
    end

    context 'with a Poor Industrial economy' do
      # Tibedied (#0) is Poor Industrial
      let(:planet) { first_planet }

      it { is_expected.to eq 'Poor Industrial' }
    end

    context 'with a Mainly Industrial economy' do
      # Leleer (#2) is Mainly Industrial
      let(:planet) { 2.times.inject(first_planet) { |p, _| p.next } }

      it { is_expected.to eq 'Mainly Industrial' }
    end

    context 'with a Rich Agricultural economy' do
      # Qube (#1) is Rich Agricultural
      let(:planet) { first_planet.next }

      it { is_expected.to eq 'Rich Agricultural' }
    end

    context 'with a Average Agricultural economy' do
      # Teaatis (#10) is Average Agricultural
      let(:planet) { 10.times.inject(first_planet) { |p, _| p.next } }

      it { is_expected.to eq 'Average Agricultural' }
    end

    context 'with a Poor Agricultural economy' do
      # Teanrebi (#18) is Poor Agricultural
      let(:planet) { 18.times.inject(first_planet) { |p, _| p.next } }

      it { is_expected.to eq 'Poor Agricultural' }
    end

    context 'with a Mainly Agricultural economy' do
      # Ontimaxe (#13) is Mainly Agricultural
      let(:planet) { 13.times.inject(first_planet) { |p, _| p.next } }

      it { is_expected.to eq 'Mainly Agricultural' }
    end

    context 'with an economy that is Poor Agricultural because of Anarchy' do
      # Sotiqu (#21) is Poor Agricultural because it is Anarchy
      let(:planet) { 21.times.inject(first_planet) { |p, _| p.next } }

      it { is_expected.to eq 'Poor Agricultural' }
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
