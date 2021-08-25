# Liquid::Tag::AttributeParser

`Liquid::Tag::AttributeParser` allows you to send familiar `html`-like attributes along with your Liquid tags to receive back a more manageable Ruby hash with all the given information.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'liquid-tag-attribute_parser'
```

And then execute:

```shell
$ bundle install
```

Or install it yourself as:

```shell
$ gem install liquid-tag-attribute_parser
```
## Usage

Three easy steps:

1. Take the raw argument data you get from the Liquid Tag
1. Use `Liquid::Tag::AttributeParser` to parse the raw data
1. Get back the data on a Hash format

#### Working example for [Jekyll tags](https://jekyllrb.com/docs/plugins/tags/):

```ruby
require "liquid/tag/attribute_parser"

module Jekyll
  class GreetingTag < Liquid::Tag
    def initialize(_tag_name, text, _tokens)
      super
      @attributes = Liquid::Tag::AttributeParser.new(text).attributes
    end

    def render(_context)
      "Hello! My name is #{@attributes[:name]} and I'm #{@attributes[:age]}"
    end
  end
end

Liquid::Template.register_tag('greeting', Jekyll::GreetingTag)
```

```html
{% greeting name="Jekyll" age=13 %}
```

## Supported data types

### `String`

```ruby
Liquid::Tag::AttributeParser.new('string="This is a string"').attributes

# => {:string=>"This is a string"}
```

### `Boolean`

```ruby
Liquid::Tag::AttributeParser.new('boolean=true').attributes

# => {:boolean=>true}
```

```ruby
Liquid::Tag::AttributeParser.new('boolean=false').attributes

# => {:boolean=>false}
```

### `Integer`

```ruby
Liquid::Tag::AttributeParser.new('integer=123').attributes

# => {:integer=>123}
```

```ruby
Liquid::Tag::AttributeParser.new('integer=+123').attributes

# => {:integer=>123}
```

```ruby
Liquid::Tag::AttributeParser.new('integer=-123').attributes

# => {:integer=>-123}
```

### `Float`

```ruby
Liquid::Tag::AttributeParser.new('float=1.23').attributes

# => {:float=>1.23}
```

```ruby
Liquid::Tag::AttributeParser.new('float=+1.23').attributes

# => {:float=>1.23}
```

```ruby
Liquid::Tag::AttributeParser.new('float=-1.23').attributes

# => {:float=>-1.23}
```

```ruby
Liquid::Tag::AttributeParser.new('float=123.0').attributes

# => {:float=>123.0}
```

```ruby
Liquid::Tag::AttributeParser.new('float=+123.0').attributes

# => {:float=>123.0}
```

```ruby
Liquid::Tag::AttributeParser.new('float=-123.0').attributes

# => {:float=>-123.0}
```

```ruby
Liquid::Tag::AttributeParser.new('float=.123').attributes

# => {:float=>0.123}
```

```ruby
Liquid::Tag::AttributeParser.new('float=+.123').attributes

# => {:float=>0.123}
```

```ruby
Liquid::Tag::AttributeParser.new('float=-.123').attributes

# => {:float=>-0.123}
```

### Combination of different data types

```ruby
Liquid::Tag::AttributeParser.new('string="This is a string" boolean=true integer=-123 float=.123').attributes

# => {:string=>"This is a string", :boolean=>true, :integer=>-123, :float=>0.123}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/unabris/liquid-tag-attribute_parser.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
