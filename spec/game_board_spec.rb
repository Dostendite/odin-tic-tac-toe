require_relative "../lib/game_board"

# - Assignment:
# You’ll need to make sure the tests that determine victory
# or loss conditions are correctly assessed.

RSpec.describe GameBoard do
  # - script method with outgoing command
  # test that the messages are sent
  describe "#set_up_players" do
  end

  # - command method
  # test the change in the observable state
  describe "#create_player" do
  end

  # - looping script method
  # test that it stops when key condition is met
  describe "#play_game" do
  end

  # - script method with outgoing command
  # test that the messages are sent
  describe "#play_turn"

  # - command method
  # test the change in the observable state
  describe "#swap_players" do
  end

  # - query method
  # test the return value
  describe "#valid_space?" do
  end

  # - command method
  # test the change in the observable state
  describe "#check_for_winner" do
  end

  # - query method
  # test the return value
  describe "#winner?" do
  end
end
