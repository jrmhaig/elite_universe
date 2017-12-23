require 'elite_universe/planet'

module EliteUniverse
  class Galaxy
    include Enumerable

    def initialize a, b, c
      @w = [a, b, c]
    end

    def planets
      255.times.inject([EliteUniverse::Planet.new(*@w)]) do |p|
        p << p[-1].next
      end
    end

    def each &block
      planets.each { |planet| block.call(planet) }
    end
  end
end
