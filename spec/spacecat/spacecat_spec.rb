require File.expand_path('../../spec_helper', __FILE__)


describe Spacecat do
  it "can be birthed" do
    Spacecat.new(:galaxy => :milky_way, :weight => 10,
                 :limbs => 4, :color => "000000").should be_a(Spacecat)
  end

  it "accepts string parameters" do
    Spacecat.new(:galaxy => "milky_way", :weight => "10",
                 :limbs => "4", :color => "000000").should be_a(Spacecat)
  end

  it "has a fitness score" do
    Spacecat.new(:galaxy => :milky_way, :weight => 2,
                 :limbs => 4, :color => "000000").score.should == 1
    Spacecat.new(:galaxy => :milky_way, :weight => 50,
                 :limbs => 6, :color => "FF00FF").score.should == 0
  end

  describe "the black_hole galaxy" do
    it "generates the same number for the same input" do
      cat = Spacecat.new(:galaxy => "black_hole", :weight => "10",
                         :limbs => "4", :color => "000000")
      hat = Spacecat.new(:galaxy => "black_hole", :weight => "10",
                         :limbs => "4", :color => "000000")
      cat.score.should == hat.score
    end
  end
end
