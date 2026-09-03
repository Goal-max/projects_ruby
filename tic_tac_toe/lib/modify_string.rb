module ModifyString 
  def remove_whitespace(string)
    string.gsub(/\s/, '')
  end

  def find_row(string)
    string.match(/[A-Z]/)[0]
  end

  def find_column(string)
    string.match(/\d/)[0]
  end
end

