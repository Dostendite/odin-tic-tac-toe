require_relative "../lib/game_board"
require_relative "../lib/player"
require "pry-byebug"

# - Assignment:
# You’ll need to make sure the tests that determine victory
# or loss conditions are correctly assessed.

RSpec.describe GameBoard do
  # - script method with outgoing command
  # test that the messages are sent
  describe "#set_up_players" do
    subject(:game_board) { described_class.new }

    context "when the input is valid ('X' or 'O')" do
      before do
        valid_input = "X"
        allow(game_board).to receive(:print)
        # is this a good practice? I might not even be stubbing the method
        # (do some research)
        allow(game_board).to receive(:gets).and_return(valid_input)
        allow(game_board).to receive(:create_player)
      end

      it "sends create player messages" do
        expect(game_board).to receive(:create_player).twice
        game_board.set_up_players
      end
    end

    pending "when the input is invalid"

    # context "when the input is invalid" do
    #   before do
    #     invalid_input = "flexbox"
    #     allow(game_board).to receive(:print)
    #     allow(game_board).to receive(:gets).and_return(invalid_input)
    #     allow(game_board).to receive(:create_player)
    #   end

    #   it "runs the method again" do
    #     expect(game_board).to receive(:set_up_players).twice
    #     game_board.set_up_players
    #   end
    # end
  end

  # - command method
  # test the change in the observable state
  describe "#create_player" do
    subject(:game_board) { described_class.new }
    context "when given 'X'" do
      let(:player_one) { game_board.create_player("X") }
      let(:player_two) { game_board.create_player("X", true) }

      it "sets player_one's value to 'X'" do
        expect(player_one.symbol).to eq("X")
      end

      it "sets player_two's value to 'O'" do
        expect(player_two.symbol).to eq("O")
      end
    end

    context "when given 'O'" do
      let(:player_one) { game_board.create_player("O") }
      let(:player_two) { game_board.create_player("O", true) }

      it "sets player one's value to 'O'" do
        expect(player_one.symbol).to eq("O")
      end

      it "sets player two's value to 'X'" do
        expect(player_two.symbol).to eq("X")
      end
    end
  end

  # - looping script method
  # test that it stops when key condition is met
  describe "#play_game" do
    context "when winner isn't declared" do
      subject(:game_board) { described_class.new }

      before do
        allow(game_board).to receive(:puts)
        allow(game_board).to receive(:play_turn)
        allow(game_board).to receive(:check_for_winner)
        allow(game_board).to receive(:announce_game_end)
      end

      it "plays turn" do
        expect(game_board).to receive(:play_turn)
        game_board.play_game
      end

      it "checks for the winner" do
        expect(game_board).to receive(:check_for_winner)
        game_board.play_game
      end
    end

    context "when winner is declared" do
      subject(:game_board) { described_class.new }

      before do
        allow(game_board).to receive(:puts)
        allow(game_board).to receive(:play_turn)
        allow(game_board).to receive(:check_for_winner)
        game_board.instance_variable_set(:@winner, "tie")
      end

      it "announces the game end" do
        expect(game_board).to receive(:announce_game_end)
        game_board.play_game
      end
    end
  end

  # - script method with outgoing command
  # test that the messages are sent
  describe "#play_turn" do
    context "when the input is valid" do
      subject(:game_board) { described_class.new }

      before do
        allow(game_board).to receive(:print)
        allow(game_board).to receive(:gets).and_return("5")
        allow(game_board).to receive(:draw_symbol)
        allow(game_board).to receive(:swap_players)
        expect(game_board).to receive(:valid_space?).and_return(true)
      end

      # it "checks if space is valid" do
      #   expect(game_board).to receive(:valid_space?)
      #   game_board.play_turn
      # end

      # it "sends draw symbol message" do
      #   expect(game_board).to receive(:draw_symbol)
      #   game_board.play_turn
      # end

      # it "sends swap players message" do
      #   expect(game_board).to receive(:swap_players)
      #   game_board.play_turn
      # end

      pending "when the input is invalid"
    end
  end

  # - command method
  # test the change in the observable state
  describe "#draw_symbol" do
    subject(:game_board) { described_class.new }

    # these tests can probably be optimized to remove repetition
    it "draws X at the correct index" do
      game_board.draw_symbol(5, "X")
      board_array = game_board.instance_variable_get(:@board_array)
      target_space = board_array[4]
      expect(target_space).to eq("X")
    end

    it "draws O at the correct index" do
      game_board.draw_symbol(8, "O")
      board_array = game_board.instance_variable_get(:@board_array)
      target_space = board_array[7]
      expect(target_space)
    end
  end

  # - command method
  # test the change in the observable state
  describe "#swap_players" do
    subject(:game_board) { described_class.new }

    before do
      player_one = game_board.create_player("X")
      player_two = game_board.create_player("X", true)
      game_board.instance_variable_set(:@player_one, player_one)
      game_board.instance_variable_set(:@player_two, player_two)
      game_board.instance_variable_set(:@current_player, player_one)
    end

    it "returns player two when current player is player one" do
      swap_result = game_board.swap_players
      player_two = game_board.instance_variable_get(:@player_two)
      expect(swap_result).to be(player_two)
    end

    it "returns player one when current player is player two" do
      game_board.instance_variable_set(:@current_player, @player_two)
      swap_result = game_board.swap_players
      player_one = game_board.instance_variable_get(:@player_one)
      expect(swap_result).to be(player_one)
    end
  end

  # - query method
  # test the return value
  describe "#valid_space?" do
    subject(:game_board) { described_class.new }
    context "when the input is valid & the space is empty" do
      it "returns true" do
        valid_input = 5
        result = game_board.valid_space?(valid_input)
        expect(result).to be_truthy
      end
    end

    context "when the input is valid but the space is occupied" do
      it "returns false" do
        valid_input = 7
        game_board.draw_symbol(7, "X")
        result = game_board.valid_space?(valid_input)
        expect(result).to be_falsy
      end
    end

    context "when the input is invalid" do
      it "returns false" do
        invalid_input = "potato"
        result = game_board.valid_space?(invalid_input)
        expect(result).to_not be_truthy
      end
    end
  end

  # - script / command method?
  describe "#check_for_winner" do
    subject(:game_board) { described_class.new }

    before do
      player_one = game_board.create_player("X")
      player_two = game_board.create_player("X", true)

      game_board.instance_variable_set(:@player_one, player_one)
      game_board.instance_variable_set(:@player_two, player_two)
    end

    context "when player one is the winner" do
      it "returns player one" do
        allow(game_board).to receive(:winner?).and_return(true)
        returned_player = game_board.check_for_winner
        expect(returned_player.symbol).to eq("X")
      end
    end

    context "when player two is the winner" do
      it "returns player two" do
        allow(game_board).to receive(:winner?).and_return(false, true)
        returned_player = game_board.check_for_winner
        expect(returned_player.symbol).to eq("O")
      end
    end

    context "when there is a tie" do
      it "returns 'tie'" do
        game_board.instance_variable_set(:@moves, 9)
        result = game_board.check_for_winner
        expect(result).to eq("tie")
      end
    end
  end

  # - query method
  # test the return value
  describe "#winner?" do
    subject(:game_board) { described_class.new }
    context "when X is the winner" do
      context "when there's a vertical alignment" do
        before do
          game_board.draw_symbol(1, "X")
          game_board.draw_symbol(4, "X")
          game_board.draw_symbol(7, "X")
        end
        it "returns true" do
          result = game_board.winner?("X")
          expect(result).to be_truthy
        end
      end

      context "when there's a horizontal alignment" do
        before do
          game_board.draw_symbol(7, "X")
          game_board.draw_symbol(8, "X")
          game_board.draw_symbol(9, "X")
        end
        it "returns true" do
          result = game_board.winner?("X")
          expect(result).to be_truthy
        end
      end

      context "when there's a diagonal alignment" do
        before do
          game_board.draw_symbol(1, "X")
          game_board.draw_symbol(5, "X")
          game_board.draw_symbol(9, "X")
        end
        it "returns true" do
          result = game_board.winner?("X")
          expect(result).to be_truthy
        end
      end
    end

    context "when O is the winner" do
      context "when there's a vertical alignment" do
        before do
          game_board.draw_symbol(3, "O")
          game_board.draw_symbol(6, "O")
          game_board.draw_symbol(9, "O")
        end
        it "returns true" do
          result = game_board.winner?("O")
          expect(result).to be_truthy
        end
      end

      context "when there's a horizontal alignment" do
        before do
          game_board.draw_symbol(4, "O")
          game_board.draw_symbol(5, "O")
          game_board.draw_symbol(6, "O")
        end
        it "returns true" do
          result = game_board.winner?("O")
          expect(result).to be_truthy
        end
      end

      context "when there's a diagonal alignment" do
        before do
          game_board.draw_symbol(3, "O")
          game_board.draw_symbol(5, "O")
          game_board.draw_symbol(7, "O")
        end
        it "returns true" do
          result = game_board.winner?("O")
          expect(result).to be_truthy
        end
      end
    end

    context "when the board is empty" do
      it "returns nil" do
        result = game_board.winner?("X")
        expect(result).to be_falsy
      end
    end
    context "when there is a tie" do
      before do
        tied_board = %w[O O X X X O O X O]
        game_board.instance_variable_set(:@game_board, tied_board)
      end

      it "returns nil for X" do
        result = game_board.winner?("X")
        expect(result).to be_falsy
      end

      it "returns nil for O" do
        result = game_board.winner?("O")
        expect(result).to be_falsy
      end
    end
  end
end
