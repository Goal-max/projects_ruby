class SerializeProcessor
  def initialize
    @serializer = JSON
  end

  def serialize_processor(var)
    @var = var
    if serialize_method?
      @var.serialize
    else
      @serializer.dump(var)
    end
  end

  def serialize_method?
    @var.methods.include?(:serialize)
  end

  def unserialize_processor(string)
    @string = string
    @unserialized = @serializer.parse(@string, symbolize_names: true)
    if custom_object?
      obj = class_name.new
      obj.unserialize(@string)
      obj
    else
      @unserialized
    end
  end

  def custom_object?
    contains_class_key? if @unserialized.class == Hash 
  end

  def contains_class_key?
    @unserialized.include?(:class)
  end

  def class_name
    Module.const_get(@unserialized[:class])
  end
end
