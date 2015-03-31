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

    def send_data(key, *args, &block)
      data.send(key, *args, &block)
    end

    private

    def process(value)
      if value.is_a?(Hash)
        RecursiveStruct.new(value)
      elsif value.is_a?(Array)
        value.map { |val| process(val) }
      else
        value
      end
    end

    def define_methods(key)
      unless respond_to?(key)
        define_singleton_method(key) { data[key] }
        define_singleton_method("#{key}=") { |value| data[key] = value }
      end
    end
  end
end
