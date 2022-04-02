module Accessors
  def attr_accessors_with_history(*methods)
    methods.each do |method|
      define_method("#{method}_history") {instance_variable_get("@#{method}_history")}
      define_method("#{method}=") do |arg|
        instance_variable_set("@#{method}_history", []) if instance_variable_get("@#{method}_history") == nil
        instance_variable_set("@#{method}_history", instance_variable_get("@#{method}_history") << arg)
        instance_variable_set("@#{method}", arg)
      end
      define_method("#{method}") {instance_variable_get("@#{method}")}
    end
  end

  def strong_attr_accessor(attr_name, attr_type)
    define_method("#{attr_name}=") do |arg|
      if arg.class.to_s == attr_type
        instance_variable_set("@#{attr_name}", arg)
      else
        raise DataError, 'attr type error'
      end
    end
    define_method("#{attr_name}") {instance_variable_get("@#{attr_name}")} 
  end
end