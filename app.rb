require 'sinatra'
require 'mongoid'
require_relative 'models/timer'

Mongoid.load!("config/mongoid.yml")

get '/' do
  @timers = Timer.all
  erb :index
end

get '/new' do
  @timer = Timer.new

  erb :new
end