class Redis
  class << self
    attr_writer :exists_returns_integer
  end
end
