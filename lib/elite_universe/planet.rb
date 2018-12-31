module EliteUniverse
  class Planet

    PAIRS = '..lexegezacebisousesarmaindirea.eratenberalavetiedorquanteisrion'
    CHARS = '..lexegezacebisousesarmaindirea.eratenberalavetiedorquanteisrion'.scan(/../)
    EXTCHARS = 'abouseitiletstonlonuthno'.scan(/../) + CHARS

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

    DESC_LIST = {
      "\u0081" => ["fabled", "notable", "well known", "famous", "noted"],
      "\u0082" => ["very", "mildly", "most", "reasonably", ""],
      "\u0083" => ["ancient", "\u0095", "great", "vast", "pink"],
      "\u0084" => ["\u009E \u009D plantations", "mountains", "\u009C", "\u0094 forests", "oceans"],
      "\u0085" => ["shyness", "silliness", "mating traditions", "loathing of \u0086", "love for \u0086"],
      "\u0086" => ["food blenders", "tourists", "poetry", "discos", "\u008E"],
      "\u0087" => ["talking tree", "crab", "bat", "lobst", "\u00B2"],
      "\u0088" => ["beset", "plagued", "ravaged", "cursed", "scourged"],
      "\u0089" => ["\u0096 civil war", "\u009B \u0098 \u0099s", "a \u009B disease", "\u0096 earthquakes", "\u0096 solar activity"],
      "\u008A" => ["its \u0083 \u0084", "the \u00B1 \u0098 \u0099","its inhabitants' \u009A \u0085", "\u00A1", "its \u008D \u008E"],
      "\u008B" => ["juice", "brandy", "water", "brew", "gargle blasters"],
      "\u008C" => ["\u00B2", "\u00B1 \u0099", "\u00B1 \u00B2", "\u00B1 \u009B", "\u009B \u00B2"],
      "\u008D" => ["fabulous", "exotic", "hoopy", "unusual", "exciting"],
      "\u008E" => ["cuisine", "night life", "casinos", "sit coms", " \u00A1 "],
      "\u008F" => ["\u00B0", "The planet \u00B0", "The world \u00B0", "This planet", "This world"],
      "\u0090" => ["n unremarkable", " boring", " dull", " tedious", " revolting"],
      "\u0091" => ["planet", "world", "place", "little planet", "dump"],
      "\u0092" => ["wasp", "moth", "grub", "ant", "\u00B2"],
      "\u0093" => ["poet", "arts graduate", "yak", "snail", "slug"],
      "\u0094" => ["tropical", "dense", "rain", "impenetrable", "exuberant"],
      # Correct spelling of wierd
      "\u0095" => ["funny", "weird", "unusual", "strange", "peculiar"],
      "\u0096" => ["frequent", "occasional", "unpredictable", "dreadful", "deadly"],
      "\u0097" => ["\u0082 \u0081 for \u008A", "\u0082 \u0081 for \u008A and \u008A", "\u0088 by \u0089", "\u0082 \u0081 for \u008A but \u0088 by \u0089","a\u0090 \u0091"],
      "\u0098" => ["\u009B", "mountain", "edible", "tree", "spotted"],
      "\u0099" => ["\u009F", "\u00A0", "\u0087oid", "\u0093", "\u0092"],
      "\u009A" => ["ancient", "exceptional", "eccentric", "ingrained", "\u0095"],
      "\u009B" => ["killer", "deadly", "evil", "lethal", "vicious"],
      "\u009C" => ["parking meters", "dust clouds", "ice bergs", "rock formations", "volcanoes"],
      "\u009D" => ["plant", "tulip", "banana", "corn", "\u00B2weed"],
      "\u009E" => ["\u00B2", "\u00B1 \u00B2", "\u00B1 \u009B", "inhabitant", "\u00B1 \u00B2"],
      "\u009F" => ["shrew", "beast", "bison", "snake", "wolf"],
      "\u00A0" => ["leopard", "cat", "monkey", "goat", "fish"],
      "\u00A1" => ["\u008C \u008B", "\u00B1 \u009F \u00A2","its \u008D \u00A0 \u00A2", "\u00A3 \u00A4", "\u008C \u008B"],
      "\u00A2" => ["meat", "cutlet", "steak", "burgers", "soup"],
      "\u00A3" => ["ice", "mud", "Zero-G", "vacuum", "\u00B1 ultra"],
      "\u00A4" => ["hockey", "cricket", "karate", "polo", "tennis"]
    }

    def initialize a, b, c
      @w = [ a, b, c ]
    end

    def name
      (@w[0] & 64 == 0 ? 2 : 3).times.inject([@w]) do |vs|
        vs << twist(vs[-1])
      end.inject('') do |name, v|
        name += CHARS[(v[2] >> 8) & 31]
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
      ((@w[1] >> 8 ) & 3) +
        (econ_n ^ 7) +
        (gov_n >> 1) +
        ((gov_n & 1) == 1 ? 2 : 1)
    end

    def next
      EliteUniverse::Planet.new *(twist twist twist twist @w)
    end

    def description
      @gs = goatsoupseed
      goatsoup "\u008F is \u0097."
    end

    private

    def version_at_least version
      # ... because I want to use new features if possible
      Gem::Version.new(RUBY_VERSION) >= Gem::Version.new(version)
    end

    def twist arr
      [
        arr[1],
        arr[2],
        (version_at_least('2.4.0') ? arr.sum : arr.inject(:+)) % 65536
      ]
    end

    def gov_n
      (@w[1] >> 3) & 7
    end

    def econ_n
      ((@w[0] >> 8) & 7) | (gov_n <= 1 ? 2 : 0)
    end

    def goatsoup source
      # Attempt to copy:
      # https://github.com/jabbalaci/Elite/blob/master/pytxtelite/pytxtelite.txt
      i = -1
      out = []
      while true
        i += 1
        c = source[i]
        return out.join.gsub(/\s+/, ' ').gsub(/\s+\./, '.') if c.nil?

        oc = c.ord

        if oc < 128
          out << c
        elsif oc <= 164
          rnd = gen_rnd_number
          num = oc

          pos = 0
          pos += 1 if rnd >= 51
          pos += 1 if rnd >= 102
          # Bug? Fix for Leleer
          #pos += 1 if rnd >= (@w[0] == 62250 ? 151 : 153)
          pos += 1 if rnd >= 153
          pos += 1 if rnd >= 204
          # Bug? Fix for Orteve: [9146, 16272, 39347]
          #pos = 0 if @w[0] == 9146 && rnd >= 255
          out << goatsoup(DESC_LIST[c][pos])
        end

        case c
        when "\u00B0"
          out << name.capitalize
        when "\u00B1"
          out << name.capitalize[0..-2]
          # Fix? include 'a' in the list
          out << name[-1] if !%w(a e i o).include? name[-1]
          out << 'ian'
        when "\u00B2"
          len = gen_rnd_number & 3
          noun = ''
          (len+1).times do |i|
            x1 = gen_rnd_number
            x2 = x1 & 0x3E
            x = x2 / 2
            #x = (gen_rnd_number & 0x3E) / 2
            noun += EXTCHARS[x]
          end
          out << noun.capitalize
        end
      end
    end

    def goatsoupseed
      [
        @w[1] & 0xFF,
        @w[1] >> 8,
        @w[2] & 0xFF,
        @w[2] >> 8
      ]
    end

    def gen_rnd_number
      x = (@gs[0] * 2) & 0xFF
      a = x + @gs[2]
      a += 1 if @gs[0] > 127
      @gs[0] = a & 0xFF
      @gs[2] = x
      a /= 256
      x = @gs[1]
      a = (a + x + @gs[3]) & 0xFF
      @gs[1] = a
      @gs[3] = x
      a
    end
  end
end
