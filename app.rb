require 'sinatra'

set :app_file, __FILE__
set :environment, :development

get '/' do
  'Hello world!'
end
