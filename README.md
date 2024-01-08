# Block Timer

Simple utility to time code in Ruby. It functions like a stop watch, allowing for 'start, lap, stop'. 

It can be easily customised to change all of its behaviour, should you want to persist a sample to your DB or remote service 
or just log to stdout.

Example:

```ruby
BlockTimer.time(name: "Order Tracking") do |stop_watch|
  # Below is an example block to time
  orders.each_with_index do |order, idx|
    notify_owner(order)
    stop_watch.lap("notify_order_#{idx}".to_sym)
  end
end

# Prints:
# I,: [Order tracking] total time taken: 4.0
# I,: 	[start_time]:     13:42:12 (0.0 seconds between, 0.0 since start)
# I,: 	[notify_order_1]: 13:42:13 (1.0 seconds between, 1.0 since start)
# I,: 	[notify_order_2]: 13:42:14 (1.0 seconds between, 2.0 since start)
# I,: 	[notify_order_3]: 13:42:15 (1.0 seconds between, 3.0 since start)
# I,: 	[end_time]:       13:42:16 (1.0 seconds between, 4.0 since start)
```

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add block_timer

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install block_timer

## Usage

**TODO**: Document custom implementations of `Printer` and `Transformer`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/block_timer.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
