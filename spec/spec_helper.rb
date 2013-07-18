# encoding: UTF-8

require 'rspec'
require 'grape'
require 'grape/client_generator'

RSpec.configure do |config|
  config.mock_with :rr
end

class DummyEndpoints < Grape::API

  version '1', {
    :using => :path,
    :cascade => false
  }

  desc "I'm a little teapot."

  set(:name, "kirk")

  get :kirk do
    puts "spock"
  end

  set(:name, "shaggy")

  post :shaggy do
    puts "scooby"
  end

end