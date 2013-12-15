# SimpleActivity

SimpleActivity is a simple gem to log users activity and show them, while
open the possibility for further working on the activities.

## Background
There are lots of functionalities based on user's activities. Beyond showing
the activities like a timeline, we may also need to assign points to users,
assign reputations to models, assign badges to users, analyze behaviours etc.

They all need raw activities to judge and act. Instead that each of those functionality
build its own activity records, SimpleActivity aims for providing such raw data
in a bit more consistent way, and open a possibility to let other libs hook their
actions after activity record created, either within request or by backend jobs(to do later)

## Installation

Add this line to your application's Gemfile:

    gem 'simple_activity'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_activity

## Usage

SimpleActivity works on controller level and locks three most important elements:
The actor(normally current_user), the target(model), and the exact controller action.
All others are optional.

To create 

## Use SimpleActivity for extending

To add actions after activity creation. TODO

    # Controller macro
    if defined? SimpleActivity
      run_after_activity_created :my_gem_method
    end

    # The my_gem_method SHOULD be defined to receive activity
    # as argument
    def my_gem_method(activity); end

## Credit

Special thanks to public_activity and Merit gem to provide inspirations and references.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
