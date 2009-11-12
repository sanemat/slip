require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'slidedown'

get '/' do
  '<a href="http://slip.sane.jp/http://github.com/sanemat/seeds/raw/master/slip.md">world of markdown to presentation!</a>'
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
  url = params[:captures].to_s
  unless url =~ %r{^https?://}
    halt 502, 'bad protocol'
  end
  Slip::render(url)
end
