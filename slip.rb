require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'slidedown'
require 'memcache'

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
  @cache = MemCache::new('localhost:11211',:namespace => 'slip')
  url = params[:captures].to_s
  http!(url)
  read(url)
end

post %r{/(.+)} do
  @cache = MemCache::new('localhost:11211',:namespace => 'slip')
  url = params[:captures].to_s
  http!(url)
  create(url)
end

put %r{/(.+)} do
  @cache = MemCache::new('localhost:11211',:namespace => 'slip')
  url = params[:captures].to_s
  http!(url)
  create(url)
end

helpers do
  def http!(url)
    unless url =~ %r{^https?://}
      halt 502, 'bad protocol'
    end
  end
  
  def create(url)
    @cache[url] = Slip::render(url)
    @cache.get(url)
  end

  def read(url)
    @cache.get(url) or @cache.add(url, Slip::render(url))
  end
end

