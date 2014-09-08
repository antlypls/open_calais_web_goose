require 'rubygems'
require 'bundler'
Bundler.require(:default)

require_relative 'lib/calais_service'
require_relative 'app/sass_handler'
require_relative 'app/coffee_handler'
require_relative 'app/calais_web'

class App < Sinatra::Base
  use SassHandler
  use CoffeeHandler
  use CalaisWeb
end
