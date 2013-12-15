# SimpleActivity

SimpleActivity is a gem for Rails to efficiently record, display and reuse users activities.

##Features
* Record key data of user activities(create, update, destroy and custom), in controler level.
* Cache machanism for displaying activities efficiently with minimal database load.
* Centralized yml configuration. Easy to read and manage. 
* Open possibility for futher working on the activities either by backend worker or per request,
with either a gem or code in app. For example, assign reputation to model/users based on activity.

## Background
I have worked on a project with light social functionality. We used several nice gems
to handle activities, reputations, user points etc. They are all great solution but
I found we are repeating the work of logging activities and analyzing it again and again.
So I thought, could we just have one representative to record activity and have others
just working on the raw data?

## Installation

Add this line to your application's Gemfile:

    gem 'simple_activity'

And then execute:

    $ bundle

And then install SimpleActivity

    $ rails generate simple_activity

## Usage

SimpleActivity works on controller level and locks three most important elements:
The actor(normally current_user), the target(model), and the exact controller action.
All others are optional.

To create 

### Record Activities
By default you don't need to do anything to get activities recorded.

Activity record will be created automaticly at basic RESTful actions :create, :update
and :destroy, with filtering out some controllers such as "registration", "session",
"admin" etc.

You can also customize the initializer to
* Add or remove actions to record
* Filtering out more or less controllers
* Disable automatic after_filter and
  * Add after_filter by yourself in controllers
  * Don't use after_filter but call the method manually

### Display Activities: Define Rules

The rules file `rules.yml` resides in `app/models/activity/rules.yml`. One purpose of
rule.yml is to helper displaying - customizing displaying logic and define things to cache.

Here is an example of rules.yml
```yml
Comment:
  create:
    verb: 'commented on'
  destroy:
    verb: 'deleted'
  _cache:
    actor:
      - nick_name
    target:
      - commentable_title
      - excerpt
Article:
  ...
```

The top level item is 

### Display Activities

## Use SimpleActivity for extending

To add actions after activity creation. TODO

    # Controller macro
    if defined? SimpleActivity
      run_after_activity_created :my_gem_method
    end

    # The my_gem_method SHOULD be defined to receive activity
    # as argument
    def my_gem_method(activity); end

## Display activities
Cache is important for displaying logic, and only for that.

Queries for activities would normally be very heavy. Let's use the example of Github. Joe
starred repo 'foo', so the repo name should be queried and shown. Bob commented on an issue,
and the comment excerpt should be queried. These activities are not consistent in model, so
it's hard to eager loading them within one query. Instead, each activity
need to get its own attributes by an extra query.

The 'cache' attribute of activity solve this problem by storing these required attributes
in db when creating the activity. So, when querying activities, only activities table will be
involved.

## Futher working on the activities
There are lots of functionalities based on user's activities. Beyond showing
the activities like a timeline, we may also need to assign points to users,
assign reputations to models, assign badges to users, analyze behaviours etc.

They all need raw activities to judge and act. Instead that each of those functionality
build its own activity records, SimpleActivity aims for providing such raw data
in a bit more consistent way, and open a possibility to let other libs hook their
actions after activity record created, either within request or by backend jobs(to do later)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
