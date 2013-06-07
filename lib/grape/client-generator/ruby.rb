# encoding: UTF-8

module Grape
  module ClientGenerator
    module Ruby

      autoload :ClientFile,         "grape/client-generator/ruby/files"
      autoload :Api,                "grape/client-generator/ruby/files"
      autoload :XmlResponseParser,  "grape/client-generator/ruby/files"
      autoload :JsonResponseParser, "grape/client-generator/ruby/files"

      autoload :RubyGenerator,      "grape/client-generator/ruby/ruby_generator"

    end
  end
end