[![GitHub release](https://img.shields.io/github/release/TobiasGSmollett/crystalg.svg)](https://github.com/TobiasGSmollett/crystalg/releases)



# Crystalg

A generic algorithm library for crystal-lang.

## Installation

Clone repository manually:

```sh
$ git clone https://github.com/TobiasGSmollett/crystalg && cd crystalg/
```

Or add this to your application's `shard.yml`:

```yaml
dependencies:
  crystalg:
    github: TobiasGSmollett/crystalg
```

## Usage

The fastest way to try it is by using Crystal Playground (`crystal play`):

```crystal
require "./crystalg"

include Crystalg::Strings

input = "mississippi"
hash = RollingHash.new input
hash.count("issi") # => 2
```

## Documentation
- [API Document](https://tobiasgsmollett.github.io/crystalg/)

## Development

crystal spec

## To Do
* Graph
  * Minimum-Cost Arborescence
  * Strongly Connected Components
  * Flow Alogorithm
    * Minimum Cost Flow
* Data Structure
  * Red Black Tree
  * Link-Cut Tree
* String Algorithm
  * Suffix Automaton
* Computational Geometry
  * Closest Pair
  * Segment Intersections
  * Tangent to a Circle
  * Common Tangent
  * Intersection of a Circle and a Polygon

## Contributing

1. Fork it ( https://github.com/TobiasGSmollett/crystalg/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [TobiasGSmollett](https://github.com/TobiasGSmollett) tobias - creator, maintainer
