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
      define_method(name.to_s + '=') do |val|
        val = case type
              when nil then val
              when :boolean then !(val.nil? || val.empty? || val)
              when :string then String(val)
              when :integer then val.to_i
              when :float then val.to_f
              when :array then Array(val)
              when :hash then Hash(val)
              else raise ArgumentError, "Invalid type(:boolean, :string, :integer, :float, :array, :hash)"
              end
        self.metadata = {} unless self.metadata.present?
        self.metadata.merge!(name => val)
      end
    end
  end
end
