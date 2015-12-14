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
      GOVS[(@w[1] >> 3 ) & 7]
    end

    def next
      EliteUniverse::Planet.new *(twist twist twist twist @w)
    end

    private
    def twist arr
      [ arr[1], arr[2], arr.inject(:+) % 65536 ]
    end
  end
end
