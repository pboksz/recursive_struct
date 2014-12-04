require 'recursive_struct/data'

class RecursiveStruct
  include RecursiveStruct::Data

  def initialize(hash = nil)
    if hash
      hash.each do |key, value|
        set_data(key, value)
      end
    end
  end

  def method_missing(name, *args)
    key = name.to_s

    if key.include?('=')
      add_setter(key.chomp('='), *args)
    elsif data.respond_to?(key)
      send_data(key, *args)
    elsif args.length == 0
      get_data(key)
    else
      super(name, *args)
    end
  end

  private

  def process(value)
    value.is_a?(Hash) ? self.class.new(value) : value
  end

  def add_setter(key, *args)
    if key == '[]' && args.length == 2
      set_data(args.first, args.last)
    elsif args.length == 1
      set_data(key, args.first)
    end
  end
end
