# frozen_string_literal: true

require 'elite_universe/planet'

module EliteUniverse
  class Galaxy
    include Enumerable

    def initialize(first, second, third)
      @initial_planet = Planet.new(first, second, third)
    end

    def each(&block)
      p = @initial_planet
      256.times do
        block.call(p)
        p = p.next
      end
    end

    def planets
      puts 'DEPRECATED'
      puts 'In place of `galaxy.planets[n]` use `galaxy[n]`'
      map { |p| p }
    end

    def [](*)
      255.times
         .lazy
         .inject([@initial_planet]) { |ps, _| ps + [ps[-1].next] }[*]
    end
  end
end
