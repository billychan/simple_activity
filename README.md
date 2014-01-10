# SimpleActivity

SimpleActivity is a gem to record, display and reuse users activities for
Rails app, in a fast, flexible and extendable way.

## Demo

[Demo site](http://intense-crag-2356.herokuapp.com/) and [source](https://github.com/billychan/simple_activity_demo402)

## Features
* **Fast** - SimpleActivity is built with speed in mind. Normally activities involve
several models and hard to eager load. SimpleActivity allows you define cache
rules beforehand so there is no JOIN on displaying activities. 

* **Flexible** - Raw data is here, you are free to do anything you like, display them
in any fashion.

* **Extendable** - Actually activity records are useful not only for displaying as timeline. There could be lots of other functionality based on activity such as assining reputation
to models, assign points to users, send notifications, granting badges etc. It would be
redudant if every feature build its own logic to record activity which is basically the same.

    To solve this problem, this gem provides a hook for other libs or your app code to work
on the raw data once activity created, either within the request or at
backend(recommended). This will remove code repetition and increase app performance.

## How it works
* Record key data of user activities(create, update, destroy and custom) in
controler level, automaticly or manually.
* Read and process cache rules to allow showing activities with minimal db load.
* Provide helper to load partials with defined names
* Provide barebone model to allow your customization if needed.
* Provide hook to further working on the activity created.

## Installation

* Add the gem to Gemfile and `bundle`

```bash
    gem 'simple_activity'
```

* Install the custom files and migration  

```bash
    $ rails generate simple_activity:install
    $ rake db:migrate
```

## Usage

### Record Activities
By default you don't need to do anything to get activities recorded.

Activity record will be created automaticly at basic RESTful actions :create, :update
and :destroy, with filtering out some controllers such as "registration", "session",
"admin" etc. You can also customize them. See more at Configurations.

### Display Activities: Define Rules

The rules file `rules.yml` resides in `app/models/activity/rules.yml`. One purpose of
rule.yml is to helper displaying - customizing displaying logic and define things to cache.

Here is an example of rules.yml
```yml
Comment:
  _cache:
    actor:
      - nick_name
    target:
      - commentable_title
      - excerpt
Article:
  ...
```

### Display Activities: By partial

A helper `render_activity(activity)` is shipped. This helper will render partial
at default place according to the activity. 

At first you need to write partials at right place. By default the helper will
look up `app/views/activities` folder. The partial name need to be a combination
of model name and action key with underscore before. e.g. `_comment_create.html.erb`,
`_article_destroy.html.slim`

You can call any attributes defined in cache rules within the partial, by concating
actor/target and the method name. e.g. `activity.actore_name`, `activity.target_title`, 
`activity.target_commentable_title`

`actor_id` and `target_id` is available natively. No need cache rules.

Also `actor` and `target` object is available if you really need them. But it's not
recommended to use them to reduce db load. `activity.actor.name` is less preferred to
`activity.actore_name` which is a cached value.

As said above, to define a link, you don't need the instance itself. Instead, id will work
as well. So, instead of `link_to activity.actor`, it's recommended to use
`link_to user_path(activity.actor_id)`

## Configurations

#### To customize the actions to record

The default actions to record activiies are `:create`, `:update` and `:destroy`.
Customize them as per your need.
```ruby
config.filtered_controllers = /(user|admin|session|registration)/i
```

#### To filter out more controllers

You don't need activity to be recorded in every controller. Below is the
default settings. You can customize them as you like.
```ruby
config.filtered_controllers = /(user|admin|session|registration)/i
```

## Extend

Reuse activity in third party libs.

Docs and demo coming soon.

## Compatability

SimpleActivity is built to work under both Rails 3 and Rails 4. The demo is on Rails 4.
The current tests are based on Rails 3, and Rails 4 ones will come later.

The current ORM is ActiveRecord. Other ORMS should be able to added in the future without
too much sweat(or coffee?)

## Contributing

This gem is still at its early stage. Very likely there are bugs and unconsidered 
situations. Thansk for your patience and trust to use it. Your bug reporting and
pull requests will be appreciated.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT. See MIT-LICENSE
