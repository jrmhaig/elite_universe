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
end
