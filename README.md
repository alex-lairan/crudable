# Crudable

Crudable is a gem that permit you to not lose time to controller when you create an API with Rails.

When you use it, he will create you automatically basis CRUD routes, as well as an Option route.

## Usage

[More information here](https://github.com/alex-lairan/crudable/wiki)

To use CRUDABLE gem, you just have to include it into your controller.

```ruby
def FoosController < ApplicationController
  include Crudable
  
  private
  
  # Params used to Create and Update resource
  def foo_params
    params.permit(:foo, :bar, :foobar, foo_set: [])
  end
  
  # Used for specify what kind of elements can be filtered
  def query_params
    params.permit(:foo, :foobar)
  end
end

def Foo < ApplicationRecord
  # Elements who can be sorted
  # Will be transform into controller method
  SORTABLE_PARAMS = %i(foo bar foobar).freeze
end
```

Inside your routes, you have to do:

```ruby
  concerns :crudable, resources_names: %i(foos)
```


Exemple:

```ruby
class AddressesController < ApplicationController
  include Crudable

  private

  def address_params
    requires = %i(street city zip)
    requires.each { |e| params.require(e) }

    params.permit(*requires, :country)
  end

  def query_params
    filters = %i(country city zip street)
    params.permit(*filters)
  end
end


class Address < ApplicationRecord
  SORTABLE_PARAMS = %i(country city zip).freeze

  validates :country, presence: true
  validates :city,    presence: true
  validates :street,  presence: true
  validates :zip,     presence: true
end

# Comming soon, should change
Rails.application.routes.draw do
  concerns :crudable, resources_names: %i(addresses)
end
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'crudable'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install crudable
```

## Contributing

Just provide a pull request (with tests *comming soon*)


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
