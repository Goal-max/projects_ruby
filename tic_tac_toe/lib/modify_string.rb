module ModifyString 
  def remove_whitespace
    self.gsub(/\s/,'')
  end

  def find_row
    self.match(/[A-Z]/)
  end

  def find_column
    self.match(/\d/)
  end
end

