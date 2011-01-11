class Fixnum
  def prime?
    return false if self < 2

    2.upto(Math.sqrt(self).to_i) do |div|
      return false if self % div == 0
    end
    return true
  end
end

