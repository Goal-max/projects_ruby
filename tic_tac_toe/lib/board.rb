class Board
  attr_reader :board_info, :players

  ROWS = %w[top middle bottom]
  COLUMNS = %w[left middle right]

  def initialize
    @board_info = create_board_structure
    @players = []
  end

  def create_board_structure
    hash = {}
    ROWS.each do |row|
      column_hash = {}
      COLUMNS.each do |column|
        column_hash[column] = nil
      end
      hash[row] = column_hash
    end
    hash
  end

  def self.straight_wins(position1, position2)
    position1.map do |first|
      position2.map do |second|
        { first => second }
      end
    end
  end

  def self.vertical_wins(position1, position2)
    position2.map do |second|
      position1.map do |first|
        { first => second }
      end
    end
  end

  def self.diagonal_wins(rows, columns)
    rows.each_with_index.map do |element, index|
      { rows[index] => columns[index] }
    end
  end

  WINNING = {
    'horizontal_wins' => straight_wins(ROWS, COLUMNS),
    'vertical_wins' => vertical_wins(ROWS, COLUMNS),
    'diagonal_wins' => [diagonal_wins(ROWS, COLUMNS),
                        diagonal_wins(ROWS, COLUMNS.reverse)]
  }

  def choice(row, column, player)
    if @board_info[row][column].nil?
      @board_info[row][column] = player
    else
      puts 'Position taken. Please try again'
      player.get_choice(self)
    end
  end

  def find_name(win_option)
    array = []
    win_option.map do |position|
      position.each_pair do |row, column|
        occupier = board_info.dig(row, column)
        unless occupier.nil?
          array << occupier
        else
          array << nil
        end
      end
    end
    array
  end

  def win?(array)
    array.all?(array[0]) && !array[0].nil?
  end

  # find names at winning positions
  def search_winner
    winner = nil
    WINNING.each_value do |winning_type|
      winning_type.each do |win_option|
        array_of_names = find_name(win_option)
        winner = array_of_names[0] if win?(array_of_names)
        break if winner
      end
      break if winner
    end
    puts "#{winner} has won. Game over" if winner
    winner
  end

  def print_winnings
    WINNING
  end
  def display
    column_string = COLUMNS.join("\t").insert(0, " \t \t ")
    puts column_string
    board_info.each_pair do |row, columns|
      array = ["#{row} \t"]
      columns.each_value do |column|
        if column.nil?
          array << "-----"
        else 
          array << "#{column.name}"
        end
      end
      puts array.join("\t ")
    end
  puts ''
  end
end
