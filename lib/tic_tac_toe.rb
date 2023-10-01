# Tic Tac Toe Ruby Project
# Maybe move the classes and stuff into
# different files after you're done

# Tic Tac Toe game board
class GameBoard
  def initialize
    @board_array = Array.new(9, ' ')
  end

  def print_board
    puts '~~~~~~~~~~~~'
    print " #{@board_array[0]} | #{@board_array[1]} | #{@board_array[2]} \n"
    puts '------------'
    print " #{@board_array[3]} | #{@board_array[4]} | #{@board_array[5]} \n"
    puts '------------'
    print " #{@board_array[6]} | #{@board_array[7]} | #{@board_array[8]} \n"
    puts '~~~~~~~~~~~~'
  end

  def play_move(pos, symbol)
    raise 'SpaceNotEmptyError' unless space_empty?(pos - 1)

    @board_array[pos - 1] = symbol
    print_board
    check_winner(symbol)
  end

  private

  def space_empty?(pos)
    @board_array[pos] == ' '
  end

  def check_winner(symbol)
    if (@board_array[0] == symbol && @board_array[1] == symbol && @board_array[2] == symbol) ||
       (@board_array[3] == symbol && @board_array[4] == symbol && @board_array[5] == symbol) ||
       (@board_array[6] == symbol && @board_array[7] == symbol && @board_array[8] == symbol) ||
       (@board_array[0] == symbol && @board_array[3] == symbol && @board_array[6] == symbol) ||
       (@board_array[1] == symbol && @board_array[4] == symbol && @board_array[7] == symbol) ||
       (@board_array[2] == symbol && @board_array[5] == symbol && @board_array[8] == symbol) ||
       (@board_array[0] == symbol && @board_array[4] == symbol && @board_array[8] == symbol) ||
       (@board_array[6] == symbol && @board_array[4] == symbol && @board_array[2] == symbol)

      puts "Player #{symbol} is the winner!"
    end
  end
end

# Player class
class Player
  def initialize(symbol)
    @symbol = symbol
  end

  def play_move
    game_board.play_move(@symbol)
  end
end

# Create game board
game_board = GameBoard.new

# Assign a symbol to each player randomly
if rand(0..1) == 1
  player_one = Player.new('X')
  player_two = Player.new('O')
else
  player_one = Player.new('O')
  player_two = Player.new('X')
end

game_on = true

# while game_on

p player_one
p player_two

game_board = GameBoard.new
game_board.print_board
