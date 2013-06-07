require 'grape'
require 'grape/client_generator'
require 'rake'
require 'fileutils'

class DummyEndpoints < Grape::API

  desc "I'm a little teapot."

  set(:name, "dummy")

  get :dummy do
    puts "hello"
  end

end

namespace :client do
  task :generate do
    output_dir = "./output"
    FileUtils.mkdir_p(output_dir)

    generator = Grape::ClientGenerator::Ruby::RubyGenerator.new(
      [DummyEndpoints]
    )

    generator.generate_each do |file_name, content|
      File.open(File.join(output_dir, file_name), "w+") do |f|
        f.write(content)
      end
    end
  end
end