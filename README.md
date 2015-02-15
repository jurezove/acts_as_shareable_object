# acts_as_shareable_object
[![Build Status](https://travis-ci.org/jurezove/acts_as_shareable_object.svg)](http://travis-ci.org/namick/obfuscate_id)
## Description
This ActiveRecord extension provides the capability to define or map attributes in your ActiveRecord models that can be easily represented with the necessary Open Graph, Twitter Cards or any other custom meta tags.

## Installation
In your Gemfile
```ruby
gem 'acts_as_shareable_object'
```
  
## Usage
### Model
```ruby
# app/models/car.rb
class Car < ActiveRecord::Base
  acts_as_shareable_object
end
```
All necessary properties are picked up from the model via `"#{namespace}_#{property}"` format. For the Twitter card type (whose meta property/name is `twitter:card`), it will try to pick up `twitter_card` from your AR model.

If you're trying to set up a Twitter Card for an app, the iPhone app's name (meta property `twitter:app:name:iphone`) will be picked up as `twitter_app_name_iphone`.

Of course, you can easily map your own attributes using `alias_method`. For example, if you have database full of apps and you're using a different attribute for the app's `title`, you can do:
```ruby
# app/models/app.rb
class App < ActiveRecord::Base
  acts_as_shareable_object
  
  alias_method :twitter_app_name_iphone, :title
end
```
And it will work just fine. :)

I'm sure I haven't considered all possible Open Graph or Twitter Card tag names so you can put in your own using:

```ruby
# app/models/car.rb
class Car < ActiveRecord::Base
  acts_as_shareable_object og: [:custom_property, nested: [:property]]
end
```

### Getting meta tags
You can use `content_for` to get the necessary meta tags in your `<head>`.
```erb
# app/views/layouts/application.html.erb
<head>
  <%= content_for(:social_meta_tags) %>
</head>
```
And then in your model's view, access the tags with `social_meta_tags_for(@car)`.
```
# app/views/cars/show.html.erb
<% content_for(:social_meta_tags) do %>
  <%= social_meta_tags_for(@car) %>
<% end %>

```

## Development

To run the tests, first clone the repo and run bundler:

    git clone git@github.com:jurezove/acts_as_shareable_object.git
    cd acts_as_shareable_object
    bundle install

Run the tests

    bundle exec rake

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
