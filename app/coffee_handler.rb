class CoffeeHandler < Sinatra::Base
  set :views, File.expand_path('../assets/coffee', __FILE__)

  get '/js/*.js' do
    filename = params[:splat].first
    coffee filename.to_sym
  end
end
