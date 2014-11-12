require 'sinatra/json'

class CalaisWeb < Sinatra::Base
  OPEN_CALAIS_API_KEY = ENV['OPEN_CALAIS_API_KEY']
  AUTH_TOKEN = ENV['AUTH_TOKEN']

  set :public_dir, File.expand_path('../../public', __FILE__)
  set :views, File.expand_path('../views', __FILE__)

  enable :logging

  get '/' do
    slim :index
  end

  post '/url' do
    halt 401 if params[:auth_token] != AUTH_TOKEN
    url = params[:url]
    calais = CalaisService.new(OPEN_CALAIS_API_KEY)
    json calais.analyze_url(url)
  end
end
