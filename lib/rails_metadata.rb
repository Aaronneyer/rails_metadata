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
                 when :boolean
                   lambda do |v|
                     if v.is_a(String)
                       if ["true", "1"].include?(v)
                         return true
                       elsif ["false", "0"].include?(v)
                         return false
                       else
                         return !v.empty?
                       end
                     else
                       return !!v
                     end
                   end
                 when :string then lambda { |v| v.to_s }
                 when :integer then lambda { |v| v.to_i }
                 when :float then lambda { |v| v.to_f }
                 when :array then lambda { |v| v.to_a }
                 when :hash then lambda { |v| v.to_hash }
                 else raise ArgumentError, "Invalid type(:boolean, :string, :integer, :float, :array, :hash)"
                 end
      define_method(name.to_s + '=') do |val|
        self.metadata = {} unless self.metadata.present?
        if val.present? || val == false
          self.metadata.merge!(name => typecast.call(val))
        else
          self.metadata.delete(name)
        end
      end
    end
  end
end
