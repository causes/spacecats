class Array
  def sum
    self.inject(0){|a,b| a + b}
  end
end
