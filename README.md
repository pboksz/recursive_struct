# RecursiveStruct

A gem to create recursive open structs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'recursive_struct'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install recursive_struct

## Usage

Passing a hash into the initializer will create an open struct that has all nested getter and setter methods.
```
hash = { a: { b: true }, c: false }
struct = RecursiveStruct.new(hash}
struct.a     # #<RecursiveStruct @data={:b=>true}>
struct.a.b   # true
struct.c     # false
```

You can also use a setter for a method that doesn't exist. A getter and setter will be generated dynamically.
```
struct = RecursiveStruct.new
struct.a = true
struct.a # true
```

If this value happens to be a hash, it will be wrapped in a RecursiveStruct.
```
struct = RecursiveStruct.new
struct.a = { b: true }
struct a # #<RecursiveStruct @data={:b=>true}>
```

## Contributing

1. Fork it ( https://github.com/pboksz/recursive_struct/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
