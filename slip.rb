require 'rubygems'
require 'sinatra'
require 'open-uri'

get '/' do
  "world of markdown to presentation!"
end

get %r{/(.+)} do
  "url is #{params[:captures]}"
end
