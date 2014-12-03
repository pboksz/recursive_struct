class RecursiveStruct
  def initialize(hash = nil)
    if hash
      hash.each do |key, value|
        add_data(key, process(value))
      end
    end
  end

  def method_missing(name, *args)
    key = name.to_s

    if key.chomp!('=') && args.length == 1
      add_data(key, process(args.first))
    else
      super(name, *args)
    end
  end

  private

  def process(value)
    value.is_a?(Hash) ? self.class.new(value) : value
  end

  def data
    @data ||= {}
  end

  def add_data(key, value)
    key = key.to_sym

    data[key] = value
    define_methods(key)
  end

  def define_methods(key)
    unless respond_to?(key)
      define_singleton_method(key) { data[key] }
      define_singleton_method("#{key}=") { |value| data[key] = value }
    end
  end
end
