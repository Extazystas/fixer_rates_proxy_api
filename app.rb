require 'sinatra'
require 'sinatra/config_file'
require 'sinatra/json'
require 'pry'
require 'mongoid'

%w{entities services}.each { |dir| Dir.glob("./#{dir}/*.rb", &method(:require)) }

Mongoid.load! 'mongoid.config'

config_file 'config/settings.yml'

set :app_file, __FILE__
set :environment, :development

get '/' do
  json 'Hello world!'
  # TODO Validate end_date > start_date
end
