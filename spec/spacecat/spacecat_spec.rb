require File.expand_path('../../spec_helper', __FILE__)


describe Spacecat do
  it "can be birthed" do
    Spacecat.new(:galaxy => :andromeda, :weight => 10,
                 :limbs => 4, :color => "000000").should be_a(Spacecat)
  end

  it "accepts string parameters" do
    Spacecat.new(:galaxy => "andromeda", :weight => "10",
                 :limbs => "4", :color => "000000").should be_a(Spacecat)
  end
end
