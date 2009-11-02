require 'rubygems'
require 'sinatra'

get '/' do
  "world of markdown to presentation!"
end

get '/:url' do
   "#{params[:url]}"
end
