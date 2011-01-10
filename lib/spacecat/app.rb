require 'sinatra/base'
require 'pp'

class Spacecat
  class App < Sinatra::Base

    get '/' do
      "hello, world!"
    end

    get '/:galaxy' do
      begin
        Spacecat.new(params).score.to_s
      rescue StandardError => e
        status 401
        e.message
      end
    end

  end
end
