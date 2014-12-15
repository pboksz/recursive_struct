require 'recursive_struct/data'

class RecursiveStruct
  include RecursiveStruct::Data

  def initialize(hash = nil)
    hash.each { |key, value| set_data(key, value) } if hash
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

  def add_setter(key, *args)
    if key == '[]' && args.length == 2
      set_data(args.first, args.last)
    elsif args.length == 1
      set_data(key, args.first)
    end
  end
end
