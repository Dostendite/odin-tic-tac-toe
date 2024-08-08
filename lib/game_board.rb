require "colorize"
require "pry-byebug"

# main game board class
class GameBoard
  def initialize
    @winning_combinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
                             [0, 3, 6], [1, 4, 7], [2, 5, 8],
                             [0, 4, 8], [6, 4, 2]]
    @board_array             = Array.new(9, " ")
    @current_player          = nil
    @player_one              = nil
    @player_two              = nil
    @winner                  = nil
    @moves                   = 0
  end

  def to_s
    system "clear"
    ret_str = ""
    ret_str << " #{@board_array[0]} | #{@board_array[1]} | #{@board_array[2]}\n"
    ret_str << "------------\n"
    ret_str << " #{@board_array[3]} | #{@board_array[4]} | #{@board_array[5]}\n"
    ret_str << "------------\n"
    ret_str << " #{@board_array[6]} | #{@board_array[7]} | #{@board_array[8]}\n"
    ret_str << "\n"
  end

  def set_up_players
    print "Choose your symbol! [X or O]: "
    input = gets.chomp.upcase

    if %w[X O].include?(input)
      @player_one = create_player(input)
      @player_two = create_player(input, true)
      @current_player = @player_one
      return
    end

    set_up_players
  end

  def create_player(symbol, swap = false)
    if swap
      symbol = symbol == "X" ? "O" : "X"
    end
    Player.new(symbol)
  end

  def play_game
    until @winner
      puts self
      play_turn
      check_for_winner
    end
    puts self
    announce_game_end
  end

  def play_turn
    print "Pick move position [1-9]: "
    input = gets.chomp.to_i

    if valid_space?(input)
      @board_array[input - 1] = @current_player.symbol
      @current_player = swap_players
      @moves += 1
      return
    end

    play_turn
  end

  def swap_players
    if @current_player == @player_one
      @player_two
    else
      @player_one
    end
  end

  def valid_space?(input)
    (1..9).include?(input) && @board_array[input - 1] == " "
  end

  def check_for_winner
    @winner = "tie" if @moves > 8
    @winner = @player_one if winner?(@player_one.symbol)
    @winner = @player_two if winner?(@player_two.symbol)
  end

  def announce_game_end
    if @winner == "tie"
      puts "Game over, it's a tie!"
    elsif @winner == @player_one
      puts "Game over! Player one (#{@player_one.symbol}) wins!"
    else
      puts "Game over! Player two (#{@player_two.symbol}) wins!"
    end
  end

  def winner?(symbol)
    @winning_combinations.each do |combination|
      score = 0
      combination.each do |index|
        score += 1 if @board_array[index] == symbol
      end
      return true if score == 3
    end
    false
  end
end
