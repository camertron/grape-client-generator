# encoding: UTF-8

module Grape
  module ClientGenerator
    module Ruby

      class RubyGenerator < Generator
        def generate_each
          client_file_classes.each do |klass|
            client_file = klass.new(self)
            yield client_file.output_file_name, client_file.render
          end
        end

        protected

        def client_file_classes
          list = [Api]
          list << XmlResponseParser if response_types.include?(:xml)
          list << JsonResponseParser if response_types.include?(:json)
          list
        end
      end

    end
  end
end