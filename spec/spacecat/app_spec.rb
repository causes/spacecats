require File.expand_path('../../spec_helper', __FILE__)


describe Spacecat::App do
  include Rack::Test::Methods

  def app
    Spacecat::App
  end

  it "works" do
    get '/'
    last_response.should be_successful
  end

  it "lists the galexies" do
    get '/galaxies'
    last_response.should =~ /^\w+(,\w+)*$/
  end

  it "scores your cat for you" do
    get '/galaxies/andromeda', {:weight => 2, :limbs => 4, :color => '000002'}
    last_response.should be_successful
    last_response.body.to_i.to_s.should == last_response.body
  end

  it "gives you a reasonable error for an unreasonable cat" do
    get '/galaxies/andromeda', {:weight => 2**31, :limbs => 4, :color => '000002'}
    last_response.status.should == 401

    get '/galaxies/andromeda', {:weight => 2, :limbs => -1, :color => '000002'}
    last_response.status.should == 401

    get '/galaxies/andromeda', {:weight => 2, :limbs => 2, :color => 'chartreuse'}
    last_response.status.should == 401

    get '/galaxies/andromeda'
    last_response.status.should == 401
  end

end
