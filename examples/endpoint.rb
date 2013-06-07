require 'grape'
require 'grape/client_generator'

class DummyEndpoints < Grape::API

  desc "Enqueue a dummy job that logs the current date and time."

  get :dummy do
    puts "hello"
  end

end

generator = Grape::ClientGenerator::Ruby::RubyGenerator.new(
  [DummyEndpoints]
)

generator.generate("./output")