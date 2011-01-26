require File.expand_path('../../spec_helper', __FILE__)


describe Spacecat::App do
  include Rack::Test::Methods

  def app
    Spacecat::App
  end

  it "works" do
    get '/'
    last_response.should be_successful
    last_response.body.should =~ /SPACECATS!/
  end

  it "sets the content type" do
    get '/'
    last_response.headers['Content-Type'].should =~ /text\/plain/
    last_response.headers['Content-Type'].should =~ /charset=utf-8/
  end

  describe 'galaxies' do
    it "lists the galaxies" do
      get '/galaxies'
      last_response.should =~ /^\w+(,\w+)*$/
    end
  end

  describe "a particular galaxy" do
    it "sets the content type" do
      get '/galaxies'
      last_response.headers['Content-Type'].should =~ /text\/plain/
      last_response.headers['Content-Type'].should =~ /charset=utf-8/
    end

    it "scores your cat for you" do
      get '/galaxies/milky_way', {:weight => 2, :limbs => 4, :color => '000000'}
      last_response.should be_successful
      last_response.body.to_i.to_s.should == last_response.body
    end

    it "accepts batches of cats" do
      get '/galaxies/milky_way',
        {:weight => "2,50,2,2", :limbs => "4,4,9,4",
         :color => "000000,000000,000000,FF0000",
         :batch => true}
      last_response.should be_successful
      last_response.body.should == "1,0,0,0"
    end

    it "tells you if your batches don't match" do
      get '/galaxies/milky_way',
        {:weight => "2", :limbs => "4,4",
         :color => "000000,000000,000000",
         :batch => true}
      last_response.status.should == 400
      #last_response.body should =~ /Attribute arrays must be the same length/
    end

    it "gives you a reasonable error for an unreasonable cat" do
      get '/galaxies/milky_way', {:weight => 2**31, :limbs => 4, :color => '000000'}
      last_response.status.should == 400

      get '/galaxies/milky_way', {:weight => 2, :limbs => -1, :color => '000000'}
      last_response.status.should == 400

      get '/galaxies/milky_way', {:weight => 2, :limbs => 2, :color => 'chartreuse'}
      last_response.status.should == 400

      get '/galaxies/milky_way'
      last_response.status.should == 400
    end
  end

end
