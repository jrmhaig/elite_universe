require 'elite_universe/planet'

module EliteUniverse
  class Galaxy
    def initialize a, b, c
      @w = [ a, b, c ]
    end

    def planets
      p = [ EliteUniverse::Planet.new(*@w)]
      255.times do
        p << p[-1].next
      end
      p
    end
  end
end
