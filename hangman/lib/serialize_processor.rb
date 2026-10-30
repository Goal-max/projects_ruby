class SerializeProcessor
  def initialize(string)
    @string = string
    @serializer = JSON
  end

  def processor
    @unserialized = @serializer.parse(@string)
  end

  def is_custom_object?
    if @unserialized.class == Hash 
      contains_class_key?
    end
  end

  def contains_class_key?(hash)
    hash.include?('class')
  end
end
