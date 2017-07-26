
module Crystalg::Strings
  def kmp(target : String, pattern : String): Array(Int32)
    # initialize
    n = Array(Int32).new(pattern.size+1, 0)
    j, n[0] = -1, -1
    (0...pattern.size).each do |i|
      while j >= 0 && pattern[i] != pattern[j]
        j = n[j]
      end
      j = j + 1
      n[i+1] = j
    end

    result = Array(Int32).new
    j = 0
    (0...target.size).each do |i|
      while j >= 0 && target[i] != pattern[j]
        j = n[j]
      end
      j += 1
      if j == pattern.size
        result << i - pattern.size + 1
        j = n[j]
      end
    end
    result
  end
end