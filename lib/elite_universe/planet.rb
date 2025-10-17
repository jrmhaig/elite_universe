# frozen_string_literal: true

module EliteUniverse
  class Planet
    CHARS = '..lexegezacebisousesarmaindirea.eratenberalavetiedorquanteisrion'.scan(/../)
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

    def initialize(first, second, third)
      @w = [first, second, third]
    end

    def name
      (@w[0].nobits?(64) ? 2 : 3).times.inject([@w]) { |vs, _| vs << twist(vs[-1]) }
                                 .inject('') { |name, v| name + CHARS[(v[2] >> 8) & 31] }
                                 .tr('.', '').capitalize
    end

    def government = GOVS[gov_n]
    def economy = ECONS[econ_n]
    def location = [@w[1] >> 8, @w[0] >> 8]
    def technology = ((@w[1] >> 8) & 3) + (econ_n ^ 7) + (gov_n >> 1) + (gov_n.allbits?(1) ? 2 : 1)
    def next = EliteUniverse::Planet.new(*(twist twist twist twist @w))

    private

    def twist(arr) = [arr[1], arr[2], arr.sum % 65_536]
    def gov_n = (@w[1] >> 3) & 7
    def econ_n = ((@w[0] >> 8) & 7) | (gov_n <= 1 ? 2 : 0)
  end
end
