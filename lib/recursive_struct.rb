class RecursiveStruct < OpenStruct
  def initialize(hash = nil)
    @table = {}

    if hash
      hash.each do |key, value|
        value = self.class.new(value) if value.is_a?(Hash)
        @table[key.to_sym] = value

        new_ostruct_member(key)
      end
    end
  end
end
