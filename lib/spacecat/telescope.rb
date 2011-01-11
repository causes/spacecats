require 'spacecat'

class Spacecat::Telescope
  WEIGHT_OPTIONS = [1, 500, 1000]
  LIMB_OPTIONS = [0, 7, 50, 67, 100]
  COLOR_OPTIONS = ["000000", "FF0000", "999999", "FF99FF", "FF00FF", "FFFFFF"]

  TESTS = []
  WEIGHT_OPTIONS.each do |weight|
    LIMB_OPTIONS.each do |limbs|
      COLOR_OPTIONS.each do |color|
        TESTS << [weight, limbs, color]
      end
    end
  end

  SCALES = {
    :andromeda => 20000,
    :cartwheel => 10000,
    :sombrero  => 10000,
    :tadpole   => 30
  }

  def self.look(galaxy)
    TESTS.map do |weight, limbs, color|
      cat = Spacecat.new(:galaxy => galaxy,
                         :weight => weight,
                         :limbs => limbs,
                         :color => color)
      score = cat.score
      bar_scale = SCALES[galaxy]
      bars = []
      bars[0] = score < 0 ? ('#'*(-score/bar_scale)).rjust(20) : ''
      bars[1] = score > 0 ? ('#'*(score/bar_scale)).ljust(20) : ''
      [weight, limbs, color, score] + bars
    end
  end
end
