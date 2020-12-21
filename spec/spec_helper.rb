require 'rspec'
require 'mongoid-rspec'
%w[entities services].each { |dir| Dir.glob("./#{dir}/*.rb", &method(:require)) }

RSpec.configure do |config|
  config.include Mongoid::Matchers
end
