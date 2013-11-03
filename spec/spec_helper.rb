require 'rack/test'
require 'sinatra'
require 'pry'
require 'json'

require_relative '../lib/server'
require_relative '../lib/delivery'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def app
  GameOfShutl::Server
end
