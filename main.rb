require_relative "lib/game_board"
require_relative "lib/player"
require "colorize"

game_board = GameBoard.new

if rand(0..1) == 1
  player_one = Player.new("X")
  player_two = Player.new("O")
else
  player_one = Player.new("O")
  player_two = Player.new("X")
end

moves = 0
puts game_board

while moves < 10

  moves += 1
  if moves == 10
    puts "It's a tie!"
    break
  elsif moves.odd?
    current_move = player_one.play_move(game_board)
    break if current_move == player_one.symbol
  else
    current_move = player_two.play_move(game_board)
    break if current_move == player_two.symbol
  end
end
