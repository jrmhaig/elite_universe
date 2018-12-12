require 'spec_helper'
require 'elite_universe/galaxy'

describe EliteUniverse::Galaxy do
  let(:galaxy) { EliteUniverse::Galaxy.new(23114, 584, 46931) }

  describe '#planets' do
    it 'gets a list of 256 planets' do
      expect(galaxy.planets.length).to eq 256
    end

    it 'gets the first 8 planets' do
      expect(galaxy.planets[0, 8].map{ |p| p.name }).to eq [
        'Tibedied',
        'Qube',
        'Leleer',
        'Biarge',
        'Xequerin',
        'Tiraor',
        'Rabedira',
        'Lave',
      ]
    end
  end

  describe '#[]' do
    it 'gets the first 8 planets' do
      expect(galaxy[0].name).to eq 'Tibedied'
      expect(galaxy[1].name).to eq 'Qube'
      expect(galaxy[2].name).to eq 'Leleer'
      expect(galaxy[3].name).to eq 'Biarge'
      expect(galaxy[4].name).to eq 'Xequerin'
      expect(galaxy[5].name).to eq 'Tiraor'
      expect(galaxy[6].name).to eq 'Rabedira'
      expect(galaxy[7].name).to eq 'Lave'
    end
  end

  describe '#map' do
    it 'runs through 256 planets' do
      # This indicates that the Enumerable methods will act on a limited list
      expect(galaxy.map(&:name).count).to eq 256
    end

    it 'returns the names of the first 8 planets' do
      # This indicates that the Enumerable methods act on the correct items
      expect(galaxy.map(&:name)[0]).to eq 'Tibedied'
      expect(galaxy.map(&:name)[1]).to eq 'Qube'
      expect(galaxy.map(&:name)[2]).to eq 'Leleer'
      expect(galaxy.map(&:name)[3]).to eq 'Biarge'
      expect(galaxy.map(&:name)[4]).to eq 'Xequerin'
      expect(galaxy.map(&:name)[5]).to eq 'Tiraor'
      expect(galaxy.map(&:name)[6]).to eq 'Rabedira'
      expect(galaxy.map(&:name)[7]).to eq 'Lave'
    end
  end
end
