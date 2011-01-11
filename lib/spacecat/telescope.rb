class Spacecat::Telescope
  def self.andromeda
    puts "Testing Andromeda"
    [
      [1, 0, "000000"],
      [1, 0, "FFFFFF"],
      [1, 100, "000000"],
      [1000, 0, "FFFFFF"],
      [1000, 100, "000000"],
      [1000, 100, "FFFFFF"],
      [500, 0, "000000"],
      [500, 0, "FFFFFF"],
      [1, 50, "000000"],
      [1, 50, "FFFFFF"],
      [500, 50, "999999"],
    ].map do |weight, limbs, color|
      cat = Spacecat.new(:galaxy => :andromeda,
                         :weight => weight,
                         :limbs => limbs,
                         :color => color)
      puts [weight, limbs, color].join(',') + ": #{cat.score}"
    end
  end
end
