require 'sinatra'
require 'pry'
require 'sinatra/config_file'

config_file 'config/settings.yml'

set :app_file, __FILE__
set :environment, :development

get '/' do
  'Hello world!'
end
