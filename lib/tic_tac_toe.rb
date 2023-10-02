# Tic Tac Toe Ruby Project
# Maybe move the classes and stuff into
# different files after you're done

# Tic Tac Toe game board
class GameBoard
  def initialize
    @board_array = Array.new(9, ' ')
  end

  def print_board
    puts
    # puts '~~~~~~~~~~~~'
    print " #{@board_array[0]} | #{@board_array[1]} | #{@board_array[2]} \n"
    puts '------------'
    print " #{@board_array[3]} | #{@board_array[4]} | #{@board_array[5]} \n"
    puts '------------'
    print " #{@board_array[6]} | #{@board_array[7]} | #{@board_array[8]} \n"
    # puts '~~~~~~~~~~~~'
    puts
  end

  def play_move(pos, symbol)
    raise 'SpaceNotEmptyError' unless space_empty?(pos - 1)

    system "clear"
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
      symbol
    end
  end
end

# Player class
class Player
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def play_move(game_board)
    print 'Pick move position (1-9): '
    pos = gets.chomp.to_i - 1

    game_board.play_move(pos, @symbol)
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

moves = 0
game_board.print_board

while moves < 9
  if moves.even?
    current_move = player_one.play_move(game_board)
    if current_move == player_one.symbol
      break
    end
  else
    current_move = player_two.play_move(game_board)
    if current_move == player_two.symbol
      break
    end
  end

  moves += 1
end
