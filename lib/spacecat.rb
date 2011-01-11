require 'array_ext'

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
    send("score_#{@galaxy}").to_i
  end

  # Andromeda likes heavy cats
  # Just one peak
  def score_andromeda
    -(weight - 500)**2 + rgb.sum
  end

  def score_cartwheel
    [
      -(weight/5 - 60)**2,
      -2*(weight/5 - 80)**2,
      -(weight/5 - 100)**2,

      (limbs - 94)**2,
      4*(limbs - 92)**2,
      (limbs - 90)**2,

      (rgb.sum/2)**2
    ].sum
  end

  def score_sombrero
    score = [
      -(weight*20 - 279)**2,
      -5000*((40-limbs).abs)
    ].sum + 150000
    [score, 0].max
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
