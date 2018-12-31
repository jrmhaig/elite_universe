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

## Deprecated methods

`galaxy.planets` will return an array of all instances of
`EliteUniverse::Planet` in an `EliteUniverse::Galaxy`. This is deprecated.
Instead of `galaxy.planets[i]` use `galaxy[i]`.

## Descriptions (work in progress)

The Goat Soup algorithm has been added to create planet descriptions as listed
[here.](http://wiki.alioth.net/index.php/Classic_Elite_planet_descriptions)
However, there appear to be difference between a few of the descriptions in the
original game and those created by Ian Bell's
[Text Elite,](http://www.elitehomepage.org/text/index.htm) from which most
versions of the algorithm are derived. For example:

* (Original BBC Micro) "The world Leleer is very noted for its pink Leleerian Itonthbi tulip plantations but plagued by deadly earthquakes."
* (Text Elite) "The world Leleer is very noted for its pink Leleerian Itonthbi tulip plantations but plagued by a vicious disease."

## License

The Elite Universe gem is available to everyone under the terms of the MIT
open source license.
Take a look at the LICENSE file in the code.

## Copyright

The Elite planet generation algorithm is copyright (c) 1984 of David Braben and
Ian Bell.

This ruby implementation is copyright (c) 2015 Joe Haig
