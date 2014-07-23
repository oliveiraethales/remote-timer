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
      '/js/jquery.js'
    ]

    js_compression :jsmin
  end

  Mongoid.load!("config/mongoid.yml")

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

  run! if app_file == $0
end
