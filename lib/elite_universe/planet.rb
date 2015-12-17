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
      'Corporate',
    ]

    ECONS = [
      'Rich Industrial',
      'Average Industrial',
      'Poor Industrial',
      'Mainly Industrial',
      'Mainly Agricultural',
      'Rich Agricultural',
      'Average Agricultural',
      'Poor Agricultural',
    ]

    def initialize a, b, c
      @w = [ a, b, c ]
    end

    def name
      name = ''
      v = @w
      l = v[0] & 64
      4.times do |i|
        if i < 3 or l > 0
          n = ( v[2] >> 8 ) & 31
          name += CHARS[n]
        end
        v = twist v
      end
      name.gsub('.', '').capitalize
    end

    def government
      GOVS[ gov_n ]
    end

    def economy
      ECONS[ econ_n ]
    end

    def location
      [ @w[1] >> 8, @w[0] >> 8 ]
    end

    def next
      EliteUniverse::Planet.new *(twist twist twist twist @w)
    end

    private
    def twist arr
      [ arr[1], arr[2], arr.inject(:+) % 65536 ]
    end

    def gov_n
      ( @w[1] >> 3 ) & 7
    end

    def econ_n
      e = ( @w[0] >> 8 ) & 7
      gov_n <= 1 ? e | 2 : e
    end
  end
end
