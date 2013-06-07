grape-client-generator
======================

Automatically generate clients for your Grape APIs.

### Installation

Install the gem as you would any other:

```
gem install grape-client-generator
```

or put it in your Gemfile.

The grape client generator is probably best used in a Rakefile.  Require it like so:

```ruby
require 'grape/client_generator'
```

### Usage

Let's say we have a little Grape API that looks like this:

```ruby
class DummyEndpoints < Grape::API

  desc "I'm a little teapot."

  get :dummy do
    puts "hello"
  end

end
```
