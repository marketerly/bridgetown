---
title: Helpers
hide_in_toc: true
order: 0
category: plugins
---

Helpers are Ruby methods you can provide to Tilt-based templates ([ERB, Slim, etc.](/docs/erb-and-beyond)) to transform data or output new content in various ways.

Example:

```ruby
class Helpers < SiteBuilder
  def build
    helper "cache_busting_url" do |url|
      "http://www.example.com/#{url}?#{Time.now.to_i}"
    end
  end
end
```

```erb
<%= cache_busting_url "mydynamicfile.js" %>
```

outputs:

```
http://www.example.com/mydynamicfile.js?1586194585
```

## Supporting Arguments

You can accept multiple arguments to your helper by simply adding them to your block or method, and optional ones are simply specified with a default value (perhaps `nil` or `false`). For example:

```ruby
def Helpers < SiteBuilder
  def build
    helper "multiply_and_optionally_add" do |input, multiply_by, add_by = nil|
      value = input * multiply_by
      add_by ? value + add_by : value
    end
  end
end
```

Then just use it like this:

```erb
5 times 10 equals <%= multiply_and_optionally_add 5, 10 %>

  output: 5 times 10 equals 50

5 times 10 plus 3 equals <%= multiply_and_optionally_add 5, 10, 3 %>

  output: 5 times 10 plus 3 equals 53
```

## Using Instance Methods

As with other parts of the Builder API, you can also use an instance method to register your helper:

```ruby
def Helpers < SiteBuilder
  def build
    helper "cache_busting_url", :bust_it
  end

  def bust_it(url)
    "http://www.example.com/#{url}?#{Time.now.to_i}"
  end
end
```

## Helpers vs. Filters vs. Tags

Filters and tags are aspects of the [Liquid](/docs/liquid) template engine which comes installed by default. The behavior of both filters and tags are roughly analogous to helpers in [Tilt-based templates](/docs/erb-and-beyond). Specialized Bridgetown filters are also made available as helpers, as are a few tags such as `webpack_path`.