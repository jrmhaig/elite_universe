# frozen_string_literal: true

require 'spec_helper'
require 'elite_universe/galaxy'

describe EliteUniverse::Galaxy do
  let(:galaxy) { described_class.new(23_114, 584, 46_931) }

  describe '#planets' do
    it 'gets a list of 256 planets' do
      expect(galaxy.planets.length).to eq 256
    end

    it 'gets the first 8 planets' do
      expect(galaxy.planets[0, 8].map(&:name)).to eq %w[Tibedied Qube Leleer Biarge Xequerin Tiraor Rabedira Lave]
    end
  end

  describe '#[]' do
    subject { galaxy[n].name }

    context 'with planet 0' do
      let(:n) { 0 }

      it { is_expected.to eq 'Tibedied' }
    end

    context 'with planet 1' do
      let(:n) { 1 }

      it { is_expected.to eq 'Qube' }
    end

    context 'with planet 2' do
      let(:n) { 2 }

      it { is_expected.to eq 'Leleer' }
    end

    context 'with planet 3' do
      let(:n) { 3 }

      it { is_expected.to eq 'Biarge' }
    end

    context 'with planet 4' do
      let(:n) { 4 }

      it { is_expected.to eq 'Xequerin' }
    end

    context 'with planet 5' do
      let(:n) { 5 }

      it { is_expected.to eq 'Tiraor' }
    end

    context 'with planet 6' do
      let(:n) { 6 }

      it { is_expected.to eq 'Rabedira' }
    end

    context 'with planet 7' do
      let(:n) { 7 }

      it { is_expected.to eq 'Lave' }
    end
  end

  describe '#map' do
    subject(:names) { galaxy.map(&:name) }

    # This indicates that the Enumerable methods will act on a limited list
    it { expect(names.length).to eq 256 }

    # This indicates that the Enumerable methods act on the correct items
    it { expect(names[0]).to eq 'Tibedied' }
    it { expect(names[1]).to eq 'Qube' }
    it { expect(names[2]).to eq 'Leleer' }
    it { expect(names[3]).to eq 'Biarge' }
    it { expect(names[4]).to eq 'Xequerin' }
    it { expect(names[5]).to eq 'Tiraor' }
    it { expect(names[6]).to eq 'Rabedira' }
    it { expect(names[7]).to eq 'Lave' }
  end
end
