# Ghost
![logo](./images/ghost.png)

Ghost is a minimalist Ruby DSL defining ghost associations in Rails — no ORM, just plain Ruby objects.

⚠️ **Note: This project is still under active development.**  
Features, interfaces, and behavior may change in future versions.

## Installation
Add this line to your application's Gemfile:
```ruby
gem "niaga-ghost"
```
And then execute:
```ruby
$ bundle
```
Or install it yourself as:
```ruby
$ gem install niaga-ghost
```

## Usage

### Resolver
Resolvers are simple Ruby objects that know how to fetch or construct related data.

In Ghost, a resolver class is responsible for responding to the lifecycle of a relation access — meaning it can hook into how and when the relation is resolved.


### Example

```ruby
# models/user.rb
class User < ApplicationRecord
  has_delegate :contacts
  # ...
end


# models/resolvers/contact_resolver.rb
class ContactResolver
  def action(base)
    generate
  end

  def generate
    collection = []

    10.times do |i|
      collection << Contact.new(i, Faker::Name.name, Faker::PhoneNumber.cell_phone)
    end

    collection
  end
end


# models/contact.rb
class Contact
  attr_accesor :id, :name, :phone_number

  def initialize(id, name, phone_numer)
    @id = id
    @name = name
    @phone_number = phone_number
  end
end
```

```ruby
  # irb
  >> user = User.first
    # #<User:0x0000000126c229b0...
  >> user.contacts
    # [#<Contact:0x0000000126c211b0, ..., ...]
```


## Contributing
1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Added some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).