# encoding: UTF-8

require 'spec_helper'

include Grape::ClientGenerator

describe Generator do
  describe "#initialize" do
    it "should use sensible defaults" do
      Generator.new([DummyEndpoints]).tap do |gen|
        gen.grape_classes.should == [DummyEndpoints]
        gen.response_types.should == [:xml]
        gen.namespace.should == "DummyEndpointsClient"
        gen.class_name.should == "Api"
        gen.default_version.should == "v1"
      end
    end

    it "should allow the defaults to be overridden" do
      gen = Generator.new([DummyEndpoints], {
        :response_types => [:json],
        :namespace => "Blarg",
        :class_name => "Hello",
        :default_version => "8"
      })

      gen.grape_classes.should == [DummyEndpoints]
      gen.response_types.should == [:json]
      gen.namespace.should == "Blarg"
      gen.class_name.should == "Hello"
      gen.default_version.should == "8"
    end
  end

  context "with a generator" do
    before(:each) do
      @generator = Generator.new([DummyEndpoints])
    end

    describe "#each_endpoint" do
      it "iterates over each endpoint" do
        endpoints = []
        @generator.each_endpoint do |endpoint|
          endpoint.should be_a(Grape::Endpoint)
          endpoints << endpoint.settings[:name]
        end
        endpoints.should == ["kirk", "shaggy"]
      end
    end

    describe "#map_endpoints" do
      it "returns an array of mapped values for the endpoints" do
        @generator.map_endpoints do |endpoint|
          endpoint.should be_a(Grape::Endpoint)
          endpoint.settings[:name]
        end.should == ["kirk", "shaggy"]
      end
    end
  end
end