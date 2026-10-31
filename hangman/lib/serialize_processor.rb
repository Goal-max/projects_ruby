class SerializeProcessor
  def initialize(string)
    @string = string
    @serializer = JSON
  end

  def processor
    @unserialized = @serializer.parse(@string)
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
    @unserialized.include?('class')
  end

  def class_name
    Module.const_get(@unserialized['class'])
  end
end
