require 'sinatra/base'
require 'pp'

require 'spacecat'

class Spacecat
  class App < Sinatra::Base

    get '/' do
      content_type 'text/markdown', :charset => 'utf-8'
      File.read('README.md')
    end

    get '/galaxies' do
      Spacecat::GALAXIES.join(',')
    end

    get '/galaxies/:galaxy' do
      begin
        Spacecat.new(params).score.to_s
      rescue StandardError => e
        status 401
        e.message
      end
    end

  end
end
