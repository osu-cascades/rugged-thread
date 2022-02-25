class Price

  def initialize(value)
    @value = value
  end

  def total 
    @value.reduce(0) { |sum, v| sum + v.price }
  end

end