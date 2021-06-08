class Redis
  class << self
    def exists_returns_integer=(value)
      @exists_returns_integer = value
    end
  end
end
