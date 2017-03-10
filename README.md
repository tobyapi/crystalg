# Crystalg [![Build Status](https://travis-ci.org/TobiasGSmollett/crystalg.svg?branch=master)](https://travis-ci.org/TobiasGSmollett/crystalg)  

A generic algorithm library for crystal-lang.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  crystalg:
    github: TobiasGSmollett/crystalg
```

## Usage

```crystal
require "crystalg"

include Crystalg::Strings

input = "mississippi"
hash = RollingHash.new input
puts hash.count("issi")
```

## Development

crystal spec

## To Do
* Graph
  * Bellman-Ford algorithm
  * Warshall Floyd
  * Kruskal
  * Topological Sort
  * Minimum-Cost Arborescence
  * Articulation Points
  * Bridges
  * Strongly Connected Components
  * Cycle Detection for a Directed Graph
  * Tree
    * Diameter
    * Height
    * Lowest Common Ancestor
    * Heavy-Light Decomposition
  * Flow Alogirithm
    * Edmons-Karp
    * Dinic
    * Ford-Fulkerson
    * Minimum Cost Flow
    * Hopcroft-Karp
* Data Structure
  * Segment Tree
  * Fenwick Tree
  * Red Black Tree
  * Link-Cut Tree
  * kD Tree
  * Leftist Heap
  * Skew Heap
* String Algorithm
  * Knuth-Morris-Pratt
  * Boyer-Moore
  * Aho-Corasick
  * Baker-Bird
  * Trie
  * Suffix Array
  * Suffix Automaton
* Number Theory
  * Prime Factorize
  * Power
  * Least Common Multiple
  * Euler's Phi Function
  * Extended Euclid Algorithm
  * Stern-Brocot Tree
  * Mobius Function
  * Carmichael Function
* Computational Geometry
  * Projection
  * Reflection
  * Counter-Clockwise
  * Parallel/Orthogonal
  * Intersection
  * Cross Point
  * Distance
  * Area
  * Is-Convex
  * Polygon-Point Containment
  * Convex Hull
  * Diameter of a Convex Polygon
  * Convex Cut
  * Closest Pair
  * Segment Intersections
  * Circle Intersection
  * Cross Points of a Circle and a Line
  * Cross Points of Circles
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
