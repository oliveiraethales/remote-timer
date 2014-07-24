require 'sinatra/base'
require 'sinatra/assetpack'
require 'sinatra/reloader' if development?
require 'mongoid'
require_relative 'models/timer'

class RemoteTimer < Sinatra::Base
  register Sinatra::Reloader if development?
  register Sinatra::AssetPack

  assets do
    js :application, [
      '/js/jquery.js',
      '/js/time-circles.js',
      '/js/index.js'
    ]

    css :application, [
      '/css/time-circles.css',
      '/css/index.css'
    ]
  end

  Mongoid.load!('config/mongoid.yml')

  get '/' do
    @timers = Timer.all

    erb :index
  end

  get '/new' do
    @timer = Timer.new

    erb :new
  end

  post '/create' do
    timer = Timer.new
    timer.name = params[:name]
    timer.running = params[:running] == 'true'
    timer.started_at = Time.now

    timer.save

    erb :index
  end

  post '/start/:id' do
    timer = Timer.find params[:id]
    timer.running = true    
    timer.save

    erb :index, layout: false
  end

  post '/stop/:id' do
    timer = Timer.find params[:id]
    timer.running = false
    timer.save

    200
  end

  post '/restart/:id' do
    timer = Timer.find params[:id]
    timer.running = true
    timer.started_at = Time.now
    timer.save

    200
  end

  run! if app_file == $0
end
