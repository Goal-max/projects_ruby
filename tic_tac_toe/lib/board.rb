require_relative 'modify_string'
 
class Board
  include ModifyString

  attr_reader :board_info, :players

  ROWS = %w[A B C]
  COLUMNS = %w[1 2 3]

  def initialize
    @board_info = setup_board
    @players = []
  end

  def setup_board
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

  def position_taken?(row, column)
    @board_info[row][column] != nil
  end

  def assign_position(row, column, player)
    @board_info[row][column] = player
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
    puts "#{winner.name} has won. Game over" if winner
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
          array << '-----'
        else
          array << "#{column.name}"
        end
      end
      puts array.join("\t ")
    end
    puts ''
  end

  def display_menu(main_menu_items)
    puts
    puts 'Tic Tac Toe'
    puts
    puts 'Select choice:'
    main_menu_items.each do |sub_item|
      puts "#{sub_item[0]}. #{sub_item[1]}"
    end
  end

  def main_menu(menu_numbers)
    welcome = ['', 'Tic Tac Toe', '', 'Select Choice:']
    menu_choice = nil
    until menu_choice
      menu_choice = ask_input(welcome)
      menu_choice = format_input(menu_choice, menu_numbers)
    end
    menu_choice
  end

  def confirm_quit
    input = ask_input('Are you sure you want to quit? Y/N')
    if input == 'y'
      input = 'Q'
    else 
      input == nil
    end
  end
end
