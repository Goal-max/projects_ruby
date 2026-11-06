module BasicSerializable
  @@serializer = JSON

  def serialize
    obj = {}
    obj['class'] = self.class
    instance_variables.map do |var|
      obj[var] =
      SerializeProcessor.new.serialize_processor(instance_variable_get(var))
    end
    @@serializer.dump(obj)
  end

  def unserialize(string)
    obj = @@serializer.parse(string, symbolize_names: true)
    obj.each_pair do |key, value|
      next if key == :class

      instance_variable_set(key,
                            SerializeProcessor.new.unserialize_processor(value))
    end
  end
end
