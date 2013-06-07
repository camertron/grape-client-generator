# encoding: UTF-8

module Grape
  module ClientGenerator

    autoload :Ruby, 'grape/client-generator/ruby'

    class Generator

      DEFAULT_RESPONSE_TYPES = [:xml]
      DEFAULT_CLASS_NAME = "Api"
      DEFAULT_VERSION = "v1"

      attr_reader :grape_classes, :response_types, :namespace, :default_version, :class_name

      def initialize(grape_classes, options = {})
        @grape_classes = grape_classes
        @response_types = options[:response_types] || DEFAULT_RESPONSE_TYPES
        @namespace = options[:namespace] || generate_namespace_from(grape_classes.first)
        @class_name = options[:class_name] || DEFAULT_CLASS_NAME
        @default_version = options[:default_version] || DEFAULT_VERSION
      end

      def each_endpoint
        @grape_classes.each do |grape_class|
          grape_class.endpoints.each do |endpoint|
            yield endpoint
          end
        end
      end

      def map_endpoints
        result = []
        each_endpoint do |endpoint|
          result << (yield endpoint)
        end
        result
      end

      protected

      def generate_namespace_from(klass)
        "#{klass.name.split("::").last}Client"
      end

    end
  end
end