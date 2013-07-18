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
          Mustache.template_path = mustache_path
          Mustache.render(File.read(input_file), params)
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
          File.join(mustache_path, "#{name}.mustache")
        end

        def mustache_path
          File.join(File.dirname(__FILE__), "mustache")
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
            :default_format => generator.response_types.first,
            :endpoints => generator.map_endpoints do |endpoint|
              {
                :path => route_options_for(endpoint)[:path],
                :path_params => route_options_for(endpoint)[:params].keys,
                :name => endpoint.settings[:name],  # expected to be set by all endpoints
                :verb => endpoint.options[:method].first.downcase
              }
            end
          }
        end

        private

        def route_options_for(endpoint)
          endpoint.routes.first.instance_variable_get(:'@options')
        end
      end

      class XmlResponseParser < ClientFile
        def output_file_name
          "xml_response_parser.rb"
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
          "json_response_parser.rb"
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