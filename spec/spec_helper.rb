require 'sinatra'
require 'rspec'
require 'mongoid'
require 'mongoid-rspec'

ENV['MONGOID_ENV'] = 'test'
Mongoid.load! 'mongoid.config'

%w[entities services serializers].each { |dir| Dir.glob("./#{dir}/*.rb", &method(:require)) }

RSpec.configure do |config|
  config.include Mongoid::Matchers

  config.before(:suite) do
    Mongoid.purge!
  end

  config.after(:each) do
    Mongoid.purge!
  end
end
