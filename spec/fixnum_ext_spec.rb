require File.expand_path('../spec_helper', __FILE__)

describe Fixnum do
  it "knows its primality" do
    1.should_not be_prime
    4.should_not be_prime
    8.should_not be_prime
    10.should_not be_prime
    12.should_not be_prime
    60.should_not be_prime

    2.should be_prime
    3.should be_prime
    5.should be_prime
    7.should be_prime
    11.should be_prime
    13.should be_prime
    19.should be_prime
    23.should be_prime
    29.should be_prime
    31.should be_prime
  end
end
