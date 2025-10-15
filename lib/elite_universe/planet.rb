# frozen_string_literal: true

module EliteUniverse
  class Planet
    CHARS = '..lexegezacebisousesarmaindirea.eratenberalavetiedorquanteisrion'.scan(/../)
    GOVS = [
      'Anarchy',
      'Feudal',
      'Multi-Government',
      'Dictatorship',
      'Communist',
      'Confederate',
      'Democratic',
      'Corporate'
    ].freeze

    ECONS = [
      'Rich Industrial',
      'Average Industrial',
      'Poor Industrial',
      'Mainly Industrial',
      'Mainly Agricultural',
      'Rich Agricultural',
      'Average Agricultural',
      'Poor Agricultural'
    ].freeze

    def initialize(first, second, third)
      @w = [first, second, third]
    end

    def name
      (@w[0].nobits?(64) ? 2 : 3).times.inject([@w]) do |vs, _|
        vs << twist(vs[-1])
      end.inject('') do |name, v|
        name + CHARS[(v[2] >> 8) & 31]
      end.tr('.', '').capitalize
    end

    def government
      GOVS[gov_n]
    end

    def economy
      ECONS[econ_n]
    end

    def location
      [@w[1] >> 8, @w[0] >> 8]
    end

    def technology
      ((@w[1] >> 8) & 3) +
        (econ_n ^ 7) +
        (gov_n >> 1) +
        (gov_n.allbits?(1) ? 2 : 1)
    end

    def next
      EliteUniverse::Planet.new(*(twist twist twist twist @w))
    end

    private

    def version_at_least?(version)
      # ... because I want to use new features if possible
      Gem::Version.new(RUBY_VERSION) >= Gem::Version.new(version)
    end

    def twist(arr)
      [
        arr[1],
        arr[2],
        (version_at_least?('2.4.0') ? arr.sum : arr.inject(:+)) % 65536
      ]
    end

    def gov_n
      (@w[1] >> 3) & 7
    end

    def econ_n
      ((@w[0] >> 8) & 7) | (gov_n <= 1 ? 2 : 0)
    end
  end
end
