require_relative "lib/game_board"
require_relative "lib/player"

game_board = GameBoard.new
game_board.set_up_players
game_board.play_game
