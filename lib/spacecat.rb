class Spacecat
  GALAXIES = [:andromeda, :cartwheel, :sombrero]
  WEIGHT_RANGE = 1..1000
  LIMB_RANGE = 0..100
  COLOR_RANGE = 0..255

  UnreasonableCat = Class.new(ArgumentError)

  attr_accessor :weight, :limbs, :color

  def initialize(params)
    @galaxy = params[:galaxy].to_sym if params[:galaxy]
    @weight = params[:weight].to_i
    @limbs = params[:limbs].to_i
    @color = params[:color]
    validate
  end

  def score
    send("score_#{@galaxy}")
  end

  # Andromeda likes heavy cats
  # Just one peak
  def score_andromeda
    -(weight - 500)**2 + rgb.inject(0){|a,b| a + b}
  end

  def score_cartwheel
  end

private

  def red
    rgb[0]
  end

  def green
    rgb[1]
  end

  def blue
    rgb[2]
  end

  def rgb
    color.scan(/../).map(&:hex)
  end

  def validate
    unless GALAXIES.include?(@galaxy)
      raise UnreasonableCat.new("Uncharted galaxy: #{@galaxy.inspect}")
    end

    unless WEIGHT_RANGE.include?(@weight)
      raise UnreasonableCat.new("Unreasonable weight: #{@weight.inspect} kilograms")
    end

    unless LIMB_RANGE.include?(@limbs)
      raise UnreasonableCat.new("Unreasonable limb count: #{@limbs.inspect}")
    end

    unless @color =~ /[0-9A-F]{6}/i
      raise UnreasonableCat.new("Blinding color: #{@color.inspect}")
    end
  end
end
