# Tic Tac Toe Ruby Project
# Maybe move the classes and stuff into
# different files after you're done

# Main game board
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

game_board = GameBoard.new
game_board.print_board
game_board.play_move(3, 'O')
game_board.play_move(5, 'O')
game_board.play_move(7, 'O')