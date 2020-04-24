module Crystalg::Random
  class Xor128
    @seed : Array(UInt64)

    def initialize(s : UInt64)
      @seed = (1..4).map do |i|
        s = 1812433253_u64 &* (s ^ (s>>30)) + i
      end
    end

    def get : UInt64
      t = (@seed[0] ^ (@seed[0]<<11))
      @seed[0], @seed[1], @seed[2] = @seed[1], @seed[2], @seed[3]
      @seed[3] = (@seed[3] ^ (@seed[3]>>19)) ^ (t ^ (t>>8))
    end
  end
end
