# encoding: UTF-8

require 'mustache'

module Grape
  module ClientGenerator
    module Ruby

      class ClientFile
        attr_reader :generator

        def initialize(generator)
          @generator = generator
        end

        def render
          ::Mustache.render(File.read(input_file), params)
        end

        def input_file
          raise NotImplementedError
        end

        def output_file_name
          raise NotImplementedError
        end

        def params
          raise NotImplementedError
        end

        protected

        def mustache_file_for(name)
          File.join(File.dirname(__FILE__), "mustache", "#{name}.mustache")
        end
      end

      class Api < ClientFile
        def output_file_name
          "api.rb"
        end

        def input_file
          mustache_file_for("api")
        end

        def params
          {
            :namespace => generator.namespace,
            :class_name => generator.class_name,
            :default_version => generator.default_version,
            :endpoints => generator.map_endpoints do |endpoint|
              {
                :path => endpoint.options[:path].first.to_s,
                :name => endpoint.settings[:name],  # expected to be set by all endpoints
                :verb => endpoint.options[:method].first.downcase
              }
            end
          }
        end
      end

      class XmlResponseParser < ClientFile
        def output_file_name
          "xml_responses_parser.rb"
        end

        def input_file
          mustache_file_for("xml_response_parser")
        end

        def params
          { :namespace => generator.namespace }
        end
      end

      class JsonResponseParser < ClientFile
        def output_file_name
          "json_responses_parser.rb"
        end

        def input_file
          mustache_file_for("json_response_parser")
        end

        def params
          { :namespace => generator.namespace }
        end
      end

    end
  end
end