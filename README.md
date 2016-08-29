### Usage

Include this gem in your project's Gemfile:

```ruby
gem "cheatz_fest", github: "mzemel/cheatz_fest"
```

Require this gem at the top of your lib, e.g.

```ruby
require 'cheatz_fest'

class Bottles
  def initialize; end

  def cheat(*args)
    CheatzFest.cheat
  end

  # alias your public methods to :cheat here
end
```

Run your tests with `bundle exec`:

`bundle exec ruby bottles/test/bottles_test.rb`