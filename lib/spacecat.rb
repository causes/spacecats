class Spacecat
  GALAXIES = [:milky_way, :andromeda, :betelgeuse]
  WEIGHT_RANGE = 1...1000
  LIMB_RANGE = 0...100
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
    puts "Scoring #{@galaxy}"
    send("score_#{@galaxy}")
  end

  def score_andromeda
    10
  end

  def score_betelgeuse
    50
  end

  def score_milky_way
    weight + limbs*10 - (color.max - color.min)*5
  end

private

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
