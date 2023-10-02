class Player
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def play_move(game_board)
    # We want the user to only be able
    # to input a number between 1 and 9
    # if they input a number outside of
    # that range, ask again (infinitely)
    print 'Pick move position [1-9]: '
    pos = gets.chomp.to_i

    if (1..9).include?(pos) && game_board.space_empty?(pos - 1)
      game_board.play_move(pos, @symbol)
    else
      loop do
        print 'Please pick a valid position [1-9]: '
        pos = gets.chomp.to_i
        break if (1..9).include?(pos) && game_board.space_empty?(pos - 1)
      end
    end

    game_board.play_move(pos, @symbol)
  end
end
