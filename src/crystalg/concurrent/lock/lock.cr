module Crystalg::Concurrent::Lock
  module Lock
    abstract def lock() 
    abstract def unlock()
  end
end