require 'elite_universe/planet'

module EliteUniverse
  class Galaxy
    include Enumerable

    def initialize a, b, c
      @initial_planet = Planet.new(a, b, c)
    end

    def each &block
      256.times.inject(@initial_planet) do |p|
        block.call(p)
        p.next
      end
    end

    def planets
      puts "DEPRECATED"
      puts "In place of `galaxy.planets[n]` use `galaxy[n]`"
      self.map { |p| p }
    end

    def [] *args
      255.times
        .lazy
        .inject([@initial_planet]) { |ps| ps + [ps[-1].next] }[*args]
    end
  end
end
