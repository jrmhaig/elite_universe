# Elite Universe

Generate planets and galaxies following the Acornsoft Elite planet generation
algorithm.

[![Build Status](https://travis-ci.org/jrmhaig/elite_universe.svg?branch=master)](https://travis-ci.org/jrmhaig/elite_universe)

## Usage

```ruby
require 'elite_universe/planet'

planet = EliteUniverse::Planet.new(44344, 5276, 5405)
planet.name                      # = Lave
```

```ruby
require 'elite_universe/galaxy'

galaxy = EliteUniverse::Galaxy.new(23114, 584, 46931)
galaxy[129].name        # = Zaonce
```

`EliteUniverse::Galaxy` is an Enumerable class and so, for example, a full list
of planet names in the galaxy can be generated with:

```ruby
galaxy.map(&:name)
```

## License

The Elite Universe gem is available to everyone under the terms of the MIT
open source license.
Take a look at the LICENSE file in the code.

## Copyright

The Elite planet generation algorithm is copyright (c) 1984 of David Braben and
Ian Bell.

This ruby implementation is copyright (c) 2015 Joe Haig
