module ModifyString 
  def remove_whitespace
    self.gsub(/\s/,'')
  end

  def length_two?
    self.length == 2
  end
  
  def find_row
    self.match(/[A-Z]/)
  end

  def find_column
    self.match(/\d/)
  end
end
