rails_no_database_in_view
===========

Prevent database access from the view.

Force loading all data from the controller by raising when the database
is accessed from the view. This can help create effective database
queries and help avoid SQL N+1 problems.

## Installation

    gem install rails_no_database_in_view

## Usage

Enable in controller:

```ruby
class ItemsController < ActionController::Base

  no_database_access_from_view! if Rails.env.development?

  ...

end
```

If the database is accessed from the view, a DatabaseAccessFromViewError
will be raised.

## Badness

You can't tell where in the view the exception came from. Yeah, that's pretty bad.

## Disclaimer

Don't use this. It probably doesn't work. :)
