class Spacecat
  GALAXIES = [:milky_way, :andromeda, :betelgeuse]
  WEIGHT_RANGE = 1...1000
  LIMB_RANGE = 0...100
  COLOR_RANGE = 0..255

  UnreasonableCat = Class.new(ArgumentError)

  attr_accessor :weight, :limbs, :color

  def initialize(galaxy, weight, limbs, color)
    @galaxy = galaxy
    @weight = weight
    @limbs = limbs
    @color = color
    validate
  end

  def score
    send("score_#{@galaxy}")
  end

  def score_milky_way
    weight + limbs*10 - (color.max - color.min)*5
  end

private

  def validate
    unless GALAXIES.include?(@galaxy)
      raise UnreasonableCat.new("Uncharted galaxy: #{@galaxy}")
    end

    unless WEIGHT_RANGE.include?(@weight)
      raise UnreasonableCat.new("Unreasonable weight: #{@weight} kilograms")
    end

    unless LIMB_RANGE.include?(@limbs)
      raise UnreasonableCat.new("Unreasonable limb count: #{@limbs}")
    end

    unless @color.all?{|c| c.is_a?(Fixnum) && COLOR_RANGE.include?(c)}
      raise UnreasonableCat.new("Blinding color: #{@color.inspect}")
    end
  end
end
