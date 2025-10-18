# frozen_string_literal: true

module EliteUniverse
  class Planet

    PAIRS = 'lexegezacebisousesarmaindirea?eratenberalavetiedorquanteisrion'
    CHARS = ['..'] + PAIRS.scan(/../)
    EXTCHARS = ('abouseitiletstonlonuthnoal' + PAIRS).scan(/../)

    GOVS = %w[
      Anarchy
      Feudal
      Multi-Government
      Dictatorship
      Communist
      Confederate
      Democratic
      Corporate
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

    DESC_PARTS = {
      ':a:' => [':*:', 'the planet :*:', 'the world :*:', 'this planet', 'this world'],
      ":b:" => [":c: :d: for :e:", ":c: :d: for :e: and :e:", ":f: by :g:", ":c: :d: for :e: but :f: by :g:","a:h: :i:"],
      ":c:" => ["very", "mildly", "most", "reasonably", ""],
      ":d:" => ["fabled", "notable", "well known", "famous", "noted"],
      ":e:" => ["its :j: :k:", "the :+: :l: :m:","its inhabitants' :n: :o:", ":p:", "its :q: :r:"],
      ":f:" => ["beset", "plagued", "ravaged", "cursed", "scourged"],
      ":g:" => [":s: civil war", ":t: :l: :m:s", "a :t: disease", ":s: earthquakes", ":s: solar activity"],
      ":h:" => ["n unremarkable", " boring", " dull", " tedious", " revolting"],
      ":i:" => ["planet", "world", "place", "little planet", "dump"],
      ":j:" => ["ancient", ":u:", "great", "vast", "pink"],
      ":k:" => [":v: :w: plantations", "mountains", ":x:", ":y: forests", "oceans"],
      ":l:" => [":t:", "mountain", "edible", "tree", "spotted"],
      ":m:" => [":z:", ":1:", ":2:oid", ":3:", ":4:"],
      ":n:" => ["ancient", "exceptional", "eccentric", "ingrained", ":u:"],
      ":o:" => ["shyness", "silliness", "mating traditions", "loathing of :5:", "love for :5:"],
      ":p:" => [":6: :7:", ":+: :z: :8:","its :q: :1: :8:", ":9: :0:", ":6: :7:"],
      ":q:" => ["fabulous", "exotic", "hoopy", "unusual", "exciting"],
      ":r:" => ["cuisine", "night life", "casinos", "sit coms", " :p: "],
      ":s:" => ["frequent", "occasional", "unpredictable", "dreadful", "deadly"],
      ":t:" => ["killer", "deadly", "evil", "lethal", "vicious"],
      ":u:" => ["funny", "weird", "unusual", "strange", "peculiar"],
      ":v:" => [":-:", ":+: :-:", ":+: :t:", "inhabitant", ":+: :-:"],
      ":w:" => ["plant", "tulip", "banana", "corn", ":-:weed"],
      ":x:" => ["parking meters", "dust clouds", "ice bergs", "rock formations", "volcanoes"],
      ":y:" => ["tropical", "dense", "rain", "impenetrable", "exuberant"],
      ":z:" => ["shrew", "beast", "bison", "snake", "wolf"],
      ":1:" => ["leopard", "cat", "monkey", "goat", "fish"],
      ":2:" => ["talking tree", "crab", "bat", "lobst", ":-:"],
      ":3:" => ["poet", "arts graduate", "yak", "snail", "slug"],
      ":4:" => ["wasp", "moth", "grub", "ant", ":-:"],
      ":5:" => ["food blenders", "tourists", "poetry", "discos", ":r:"],
      ":6:" => [":-:", ":+: :m:", ":+: :-:", ":+: :t:", ":t: :-:"],
      ":7:" => ["juice", "brandy", "water", "brew", "gargle blasters"],
      ":8:" => ["meat", "cutlet", "steak", "burgers", "soup"],
      ":9:" => ["ice", "mud", "Zero-G", "vacuum", ":+: ultra"],
      ":0:" => ["hockey", "cricket", "karate", "polo", "tennis"]
    }

    def initialize(first, second, third)
      @w = [first, second, third]
    end

    def name
      (@w[0].nobits?(64) ? 2 : 3).times.inject([@w]) { |vs, _| vs << twist(vs[-1]) }
                                 .inject('') { |name, v| name + CHARS[(v[2] >> 8) & 31] }
                                 .gsub(/[\.\?]/, '').capitalize
    end

    def government = GOVS[gov_n]
    def economy = ECONS[econ_n]
    def location = [@w[1] >> 8, @w[0] >> 8]
    def technology = ((@w[1] >> 8) & 3) + (econ_n ^ 7) + (gov_n >> 1) + (gov_n.allbits?(1) ? 2 : 1)
    def next = EliteUniverse::Planet.new(*(twist twist twist twist @w))

    def description
      @gs = goatsoupseed
      gs = goatsoup(':a: is :b:').gsub(/ \s*$?/, ' ').gsub(/^\s*|\s*$/, '')
      gs.slice(0, 1).capitalize + gs.slice(1..-1) + '.'
    end

    private

    def twist(arr) = [arr[1], arr[2], arr.sum % 65_536]
    def gov_n = (@w[1] >> 3) & 7
    def econ_n = ((@w[0] >> 8) & 7) | (gov_n <= 1 ? 2 : 0)

    def goatsoup source
      return source unless source.match(':')

      parts = source.split(/(:.:)/)
      parts.map do |part|
        if part == ':*:'
          name.capitalize
        elsif part == ':+:'
          adjective.capitalize
        elsif part == ':-:'
          len = gen_rnd_number & 3
          noun = ''
          (len+1).times do |i|
            x1 = gen_rnd_number
            x2 = x1 & 0x3E
            x = x2 / 2
            noun += EXTCHARS[x]
          end
          noun.capitalize
        elsif part.match(':')
          goatsoup(DESC_PARTS[part][next_position])
        else
          part
        end
      end.join('')
    end

    def goatsoupseed
      [
        @w[1] & 0xFF,
        @w[1] >> 8,
        @w[2] & 0xFF,
        @w[2] >> 8
      ]
    end

    def next_position
      rnd = gen_rnd_number

      pos = 0
      pos += 1 if rnd >= 51
      pos += 1 if rnd >= 102
      pos += 1 if rnd >= 153
      pos += 1 if rnd >= 204
      pos
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

    def adjective
      [
        name.capitalize[0..-2],
        (name[-1] if !%w(a e i o u).include? name[-1]),
        'ian'
      ].join
    end
  end
end
