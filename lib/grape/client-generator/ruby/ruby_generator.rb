# encoding: UTF-8

module Grape
  module ClientGenerator
    module Ruby

      class RubyGenerator < Generator
        def generate(output_path)
          client_file_classes.each do |klass|
            client_file = klass.new(self)
            output_file = File.join(output_path, client_file.output_file_name)
            write_file(output_file, client_file.render)
          end
        end

        protected

        def client_file_classes
          [Api, XmlResponseParser, JsonResponseParser]
        end

        def write_file(path, contents)
          File.open(path, "w+") { |f| f.write(contents) }
        end
      end

    end
  end
end