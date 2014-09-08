class SassHandler < Sinatra::Base
  set :views, File.expand_path('../assets/sass', __FILE__)
  set :scss, cache_store: Sass::CacheStores::Memory.new

  get '/css/*.css' do
    filename = params[:splat].first
    scss filename.to_sym
  end
end
