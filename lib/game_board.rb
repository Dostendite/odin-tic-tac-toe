class GameBoard
  def initialize
    @board_array = Array.new(9, " ")
  end

  def to_s
    system "clear"
    puts
    ret_str = ""
    ret_str << " #{@board_array[0]} | #{@board_array[1]} | #{@board_array[2]}\n"
    ret_str << "------------\n"
    ret_str << " #{@board_array[3]} | #{@board_array[4]} | #{@board_array[5]}\n"
    ret_str << "------------\n"
    ret_str << " #{@board_array[6]} | #{@board_array[7]} | #{@board_array[8]}\n"
    ret_str << "\n"
  end

  def play_move(pos, symbol)
    @board_array[pos - 1] = symbol
    print_board
    check_winner(symbol)
  end

  def space_empty?(pos)
    @board_array[pos] == " "
  end

  private

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
