require 'sinatra/base'
require 'sinatra/assetpack'
require 'sinatra/reloader' if development?
require 'mongoid'
require_relative 'app/models/timer'

class RemoteTimer < Sinatra::Base
  register Sinatra::Reloader if development?
  register Sinatra::AssetPack

  assets do
    js :application, [
      '/js/jquery.js',
      '/js/jquery.pjax.js',
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
    timer.elapsed = 0

    timer.save

    redirect to('/')
  end

  put '/start/:id' do
    timer = Timer.find params[:id]
    timer.started_at = Time.now
    timer.running = true
    timer.save

    redirect to('/')
  end

  put '/stop/:id' do
    timer = Timer.find params[:id]
    timer.running = false
    timer.elapsed = params[:elapsed]
    timer.save

    redirect to('/')
  end

  put '/resume/:id' do
    timer = Timer.find params[:id]
    timer.running = true
    timer.started_at = 
    timer.elapsed = params[:elapsed]
    timer.save

    redirect to('/')
  end

  put '/restart/:id' do
    timer = Timer.find params[:id]
    timer.running = true
    timer.started_at = Time.now
    timer.elapsed = 0
    timer.save

    redirect to('/')
  end

  delete '/delete/:id' do
    timer = Timer.find params[:id]
    timer.destroy!

    redirect to('/')
  end    

  run! if app_file == $0
end
