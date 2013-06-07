require 'grape'
require 'grape/client_generator'

class DummyEndpoints < Grape::API

  desc "I'm a little teapot."

  get :dummy do
    puts "hello"
  end

end

generator = Grape::ClientGenerator::Ruby::RubyGenerator.new(
  [DummyEndpoints]
)

generator.generate("./output")