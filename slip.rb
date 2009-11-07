require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'slidedown'

get '/' do
  "world of markdown to presentation!"
end

class Slip < SlideDown
  def self.render(source_path, template = "default")
    if source_path
      slideshow = new(open(source_path).read)
      slideshow.render(template)
    end
  end
end

get %r{/(.+)} do
  "#{Slip::render(params[:captures].to_s)}"
end
