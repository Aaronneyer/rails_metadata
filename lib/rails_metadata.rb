require "rails_metadata/version"

module RailsMetadata
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    def metadata(name, type=nil)
      define_method(name.to_s) do
        self.metadata = {} unless self.metadata.present?
        self.metadata[name]
      end
      typecast = case type
                 when nil then val
                 when :boolean then lambda { |v| v.is_a?(String) ? v.empty? : !!v }
                 when :string then lambda { |v| v.to_s }
                 when :integer then lambda { |v| v.to_i }
                 when :float then lambda { |v| v.to_f }
                 when :array then lambda { |v| v.to_a }
                 when :hash then lambda { |v| v.to_hash }
                 else raise ArgumentError, "Invalid type(:boolean, :string, :integer, :float, :array, :hash)"
                 end
      define_method(name.to_s + '=') do |val|
        self.metadata = {} unless self.metadata.present?
        self.metadata.merge!(name => typecast.call(val))
      end
    end
  end
end
