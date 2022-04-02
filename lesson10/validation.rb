module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :validation
    #validation_type: 
    # presence
    # format
    # type
    def validate(attr_name, validation_type, *param)
      @parameters ||= []
      @parameters << {attr_name => {type_validation: validation_type, args: param}}
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    raise "error"
      false
    end

    def validate!
    #start all validations
      self.class.instance_variable_get(:@parameters).each do |value|
        value.each do |attr_name, data_valid|
          variable = instance_variable_get("@#{attr_name}")
          send(data_valid[:type_validation], variable, data_valid[:args])
        end
      end
    end

    def presence(var, ext)
      raise "Presence error #{var}" if var.nil? || var.empty?
    end

    def format(var, ext)
      raise "Format error #{var}" unless var.to_s =~ ext
    end

    def type(var, ext)
      raise "Type error #{var}" unless var.kind_of?(ext)
    end
  end
end