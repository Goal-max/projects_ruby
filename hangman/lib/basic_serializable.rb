module BasicSerializable
  @@serializer = JSON

  def serialize
    obj = {}
    instance_variables.map do |var|
      @var_value = instance_variable_get(var)
      obj[var] = @@serializer.dump(@var_value)
    end
    @@serializer.dump(obj)
  end

  def unserialize(string)
    obj = @@serializer.parse(string) 
    obj.each_pair do |key, value|
      instance_variable_set(key, @@serializer.parse(value))
    end
  end
end
