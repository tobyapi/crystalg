module Crystalg::Helper
  def self.assert(pred : Bool)
    return if pred
    raise "Error: you've found a bug. Please open an issue, including source code that will allow us to reproduce the bug: https://github.com/TobiasGSmollett/crystalg/issues"
  end
end
