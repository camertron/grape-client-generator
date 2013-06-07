# encoding: UTF-8

require 'spec_helper'

include Grape::ClientGenerator
include Grape::ClientGenerator::Ruby

describe Api do
  describe "#render" do
    it "wraps the code in a module and a class with the given names" do
      generator = Generator.new([DummyEndpoints], {
        :namespace => "AwesomeClient",
        :class_name => "GreatApi"
      })

      Api.new(generator).render.tap do |code|
        code.should match(/module AwesomeClient/)
        code.should match(/class GreatApi/)
      end
    end

    it "renders a Ruby method for each endpoint with the correct HTTP verb" do
      generator = Generator.new([DummyEndpoints])
      Api.new(generator).render.tap do |code|
        code.should match(/def kirk.*\n\s*make_request\("get"/)
        code.should match(/def shaggy.*\n\s*make_request\("post"/)
      end
    end
  end
end

describe XmlResponseParser do
  describe "#render" do
    it "wraps the code in the right module namespace" do
      generator = Generator.new([DummyEndpoints], :namespace => "AwesomeClient")
      XmlResponseParser.new(generator).render.tap do |code|
        code.should match(/module AwesomeClient/)
      end
    end
  end
end

describe JsonResponseParser do
  describe "#render" do
    it "wraps the code in the right module namespace" do
      generator = Generator.new([DummyEndpoints], :namespace => "AwesomeClient")
      JsonResponseParser.new(generator).render.tap do |code|
        code.should match(/module AwesomeClient/)
      end
    end
  end
end