require 'sinatra/base'
require 'pp'

require 'spacecat'

class Spacecat
  class App < Sinatra::Base

    before do
      content_type 'text/plain', :charset => 'utf-8'
    end

    get '/' do
      content_type 'text/markdown', :charset => 'utf-8'
      File.read('README.md')
    end

    get '/galaxies' do
      Spacecat::GALAXIES.join(',')
    end

    get '/galaxies/:galaxy' do
      begin
        if params[:batch]
          all_weights = params[:weight].split(',')
          all_limbs = params[:limbs].split(',')
          all_colors = params[:color].split(',')
          attr_sizes = [all_weights.size, all_limbs.size, all_colors.size]

          if attr_sizes.uniq.size > 1
            raise ArgumentError.new(<<-ERR)
              Attribute arrays must be the same length.
              Weights: #{all_weights.size}
              Limbs: #{all_limbs.size}
              Colors: #{all_colors.size}
            ERR
          end

          attrs = all_weights.zip(all_limbs, all_colors)
          attrs.map do |weight, limbs, color|
            Spacecat.new(:galaxy => params[:galaxy], :weight => weight,
                         :limbs => limbs, :color => color).score
          end.join(',')
        else
          Spacecat.new(params).score.to_s
        end
      rescue StandardError => e
        status 401
        e.message
      end
    end

  end
end
