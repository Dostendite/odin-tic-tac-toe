require_relative 'game_board'
require_relative 'player'

# Game logic

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

while moves < 10

  moves += 1
  if moves == 10
    puts "It's a tie!"
    break
  elsif moves.odd?
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
end
