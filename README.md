grape-client-generator
======================

Automatically generate clients for your Grape APIs.

### Installation

Install the gem as you would any other:

```
gem install grape-client-generator
```

or put it in your Gemfile.

The grape-client-generator is probably best used in a Rakefile.  Require it like so:

```ruby
require 'grape/client_generator'
```

### Usage

Let's say we have a little Grape API that looks like this:

```ruby
class DummyEndpoints < Grape::API

  desc "I'm a little teapot."

  set(:name, "dummy")

  get :dummy do
    puts "hello"
  end

end
```

**NOTE**: Pay special attention to the call to `set(:name, ...)` above.  grape-client-generator expects all endpoints to give themselves a name that will be used as the method name in the generated class.

grape-client-generator lets you automatically generate a (Ruby) consumer for this API that could potentially be packaged up into a gem.  The `RubyGenerator` class takes in an array of `Grape::API`s to process as well as a number of additional options like `:namespace`, `:class_name`, `:default_version`, and `:response_types`.  Here's an example:

```ruby
generator = Grape::ClientGenerator::Ruby::RubyGenerator.new([DummyEndpoints], {
  :namespace => "MyClient",
  :class_name => "Api",
  :default_version => "v1",
  :response_types => [:xml, :json]
})
```

To generate the source code for your client, use the `generate_each` method:

```ruby
generator.generate_each do |file_name, content|
  File.open(File.join("./output", file_name), "w+") do |f|
    f.write(content)
  end
end
```

### Disclaimers

This gem makes quite a few assumptions about your Grape endpoints and is far from complete.  For example, it expects each endpoint to have a simple path (i.e. no named arguments) and that you're placing the version in the url (eg. http://mysite.com/v1/...).  Have a feature in mind you'd like to see added?  Submit a pull request!

### Requirements

You'll need to add grape-client-generator into an environment that has access to Grape, although it is not specifically listed as a dependency.

The mustache gem is used to assemble the generated Ruby source files.

If you'd like to use the `JsonResponseParser` that grape-client-generator can generate, you'll need to add one of the json gems into your environment, usually either `json` or `json-pure`.

### Running Tests

Run `bundle exec rake` or `bundle exec rspec`.

### Authors

* Cameron C. Dutro: https://github.com/camertron

## Links
* grape [https://github.com/intridea/grape](https://github.com/intridea/grape)

## License

Licensed under the Apache License, Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
