class RecursiveStruct
  module Data
    def data
      @data ||= {}
    end

    def set_data(key, value)
      key = key.to_sym

      data[key] = process(value)
      define_methods(key)
    end

    def get_data(key)
      data[key.to_sym]
    end

    def send_data(key, *args)
      data.send(key, *args)
    end

    private

    def process(value)
      value.is_a?(Hash) ? RecursiveStruct.new(value) : value
    end

    def define_methods(key)
      unless respond_to?(key)
        define_singleton_method(key) { data[key] }
        define_singleton_method("#{key}=") { |value| data[key] = value }
      end
    end
  end
end
