require_relative '../lib/sort'

describe Game do
  describe '#select_players_names_and_symbols' do
    context 'when user gives 2 names' do
      subject(:game) { described_class.new }
      let(:players) { instance_double(Players) }

      before do
        player1_name = 'Tom'
        player2_name = 'Blazej'
        allow(game).to receive(:gets).and_return(player1_name, player2_name)
        allow(game).to receive(:puts)
      end

      it 'creates 2 objects' do
        expect(Players).to receive(:new).twice
        game.select_players_names_and_symbols
      end
    end
  end

  describe '#create_board' do
    subject(:game) { described_class.new }

    it "creates board full of '  |'"  do
      game.create_board

      actual_board = game.board.board

      actual_board.each do |row|
        expect(row).to all(eq('  |'))
      end
    end
  end

  describe '#somebody_wins?' do
    context 'when method is called and somebody wins' do
      subject(:game) { described_class.new }
      let(:board) { instance_double(Board, winner: false) }
      let(:player1) { instance_double(Players, name: 'Tom', symbol: "\u26AA") }
      let(:player2) { instance_double(Players, name: 'Bob', symbol: "\u26AB") }
  
      before do
        game.instance_variable_set(:@board, board)
        game.instance_variable_set(:@player1, player1)
        game.instance_variable_set(:@player2, player2)

        allow(board).to receive(:check_row_score).with(player1).and_return(false)
        allow(board).to receive(:check_row_score).with(player2).and_return(true)
        allow(board).to receive(:check_column_score).with(player1).and_return(false)
        allow(board).to receive(:check_column_score).with(player2).and_return(false)
        allow(board).to receive(:check_diagonal_score).with(player1).and_return(false)
        allow(board).to receive(:check_diagonal_score).with(player2).and_return(false)
        allow(board).to receive(:check_anti_diagonal_score).with(player1).and_return(false)
        allow(board).to receive(:check_anti_diagonal_score).with(player2).and_return(false)
      end

      it 'returns TRUE' do
        result = game.somebody_wins?
        expect(result).to eq(true)
      end
    end

    context 'when method is called and nobody wins' do
      subject(:game) { described_class.new }
      let(:board) { instance_double(Board, winner: false) }
      let(:player1) { instance_double(Players, name: 'Tom', symbol: "\u26AA") }
      let(:player2) { instance_double(Players, name: 'Ben', symbol: "\u26AB") }

      before do
        game.instance_variable_set(:@board, board)
        game.instance_variable_set(:@player1, player1)
        game.instance_variable_set(:@player2, player2)

        allow(board).to receive(:check_row_score).with(player1).and_return(false)
        allow(board).to receive(:check_row_score).with(player2).and_return(false)
        allow(board).to receive(:check_column_score).with(player1).and_return(false)
        allow(board).to receive(:check_column_score).with(player2).and_return(false)
        allow(board).to receive(:check_diagonal_score).with(player1).and_return(false)
        allow(board).to receive(:check_diagonal_score).with(player2).and_return(false)
        allow(board).to receive(:check_anti_diagonal_score).with(player1).and_return(false)
        allow(board).to receive(:check_anti_diagonal_score).with(player2).and_return(false)
      end

      it 'returns FALSE' do
        result = game.somebody_wins?
        expect(result).to eq(false)
      end
    end
  end

  describe '#board_full?' do
    context 'when board is full' do
      subject(:game) { described_class.new }
      let(:board) { instance_double(Board) }
      let(:board_array) { Array.new(6) { Array.new(7) } }
      let(:player1_symbol) { "\u26AA" }

      before do
        game.instance_variable_set(:@board, board)
        game.instance_variable_set(:@player1_symbol, player1_symbol)

        allow(board).to receive(:board).and_return(board_array)

        board.board.map! do |row|
          row.map { |el| el = player1_symbol}
        end
      end

      it 'returns TRUE' do
        result = game.board_full?
        expect(result).to eq(true)
      end
    end

    context 'when board is NOT full' do
      subject(:game) { described_class.new }
      let(:board) { instance_double(Board) }
      let(:board_array) { Array.new(6) { Array.new(7) } }
      let(:player1_symbol) { "\u26AB " }

      before do
        game.instance_variable_set(:@board, board)
        game.instance_variable_set(:@player1_symbol, player1_symbol)

        allow(board).to receive(:board).and_return(board_array)

        board.board[0][1] = player1_symbol
      end

      it 'returns FALSE' do
        result = game.board_full?
        expect(result).to eq(false)
      end
    end
  end

  describe '#select_which_player_plays_first' do
    context 'when user select player 1' do
      subject(:game) { described_class.new }
      let(:player1) { instance_double(Players, name: 'Tom', symbol: "\u26AA") }
      let(:player2) { instance_double(Players, name: 'Marek', symbol: "\u26AB") }

      before do
        message = "Which one of you wants to play first? Please type 'player 1' or 'player 2'"
        answer = 'player 1'

        allow(game).to receive(:puts).with(message)
        allow(game).to receive(:gets).and_return(answer)
        
        game.instance_variable_set(:@player1, player1)
        game.instance_variable_set(:@player2, player2)
      end
      
      it 'sets first_player to be player1 and second_player to be player2' do
        game.select_which_player_plays_first
        expect(game.instance_variable_get(:@first_player)).to eq(player1)
        expect(game.instance_variable_get(:@second_player)).to eq(player2)

      end
    end

    context 'when user select player 2' do
      subject(:game) { described_class.new }
      let(:player1) { instance_double(Players, name: 'Adam', symbol: "\u26AA") }
      let(:player2) { instance_double(Players, name: 'Kamil', symbol: "\u26AB") }

      before do
        message = "Which one of you wants to play first? Please type 'player 1' or 'player 2'"
        answer = 'player 2'

        allow(game).to receive(:puts).with(message)
        allow(game).to receive(:gets).and_return(answer)


        game.instance_variable_set(:@player1, player1)
        game.instance_variable_set(:@player2, player2)
      end

      it 'sets first_player to be player2 and second_player to be player1' do
        game.select_which_player_plays_first
        expect(game.instance_variable_get(:@first_player)).to eq(player2)
        expect(game.instance_variable_get(:@second_player)).to eq(player1)
      end
    end

    context 'when user makes typo mistake once' do
      subject(:game) { described_class.new }

      before do
        message = "Which one of you wants to play first? Please type 'player 1' or 'player 2'"

        allow(game).to receive(:puts).with(message)
      end

      it 'returns message and ask for new answer' do
        message2 = "I'm sorry, it looks like you made a typo. Please write again 'player 1' or 'player 2'"
        expect(game).to receive(:puts).with(message2).once

        allow(game).to receive(:gets).and_return('blabla', 'player 1')

        game.select_which_player_plays_first
      end
    end
  end

  describe '#play_round' do
    context 'when it is first round' do
      subject(:game) { described_class.new }
      let(:player1) { instance_double(Players, name: 'Adam', symbol: "\u26AA") }
      let(:player2) { instance_double(Players, name: 'Ewa', symbol: "\u26AB") }
      let(:first_player) { player1 }
      let(:second_player) { player2 }


      before do
        game.instance_variable_set(:@player1, player1)
        game.instance_variable_set(:@player2, player2)
        game.instance_variable_set(:@first_player, first_player)
        game.instance_variable_set(:@second_player, second_player)
      end

      it 'checks if next_turn_player variable is nil' do
        expect(game.instance_variable_get(:@next_turn_player)).to eq(nil)
      end

      xit 'calls #make_move with @first_player' do
        expect(game).to receive(:make_move).with(first_player)
        game.play_round
      end

      xit 'assigns @second_player to next_turn_player' do
        game.play_round
        expect(game.instance_variable_get(:@next_turn_player)).to eq(second_player)
      end
    end

    context 'when it is second round and @first_player is playing' do
      subject(:game) { described_class.new }
      let(:player1) { instance_double(Players, name: 'Ross', symbol: "\u26AA") }
      let(:player2) { instance_double(Players, name: 'Rob', symbol: "\u26AB") }
      let(:first_player) { player1 }
      let(:second_player) { player2 }

      before do
        game.instance_variable_set(:@player1, player1)
        game.instance_variable_set(:@player2, player2)
        game.instance_variable_set(:@first_player, first_player)
        game.instance_variable_set(:@second_player, second_player)
      end

      it 'checks if next_turn_player variable is nil' do
        expect(game.instance_variable_get(:@next_turn_player)).to eq(nil)
      end

      it 'calls #make_move with @first_player' do
        expect(game).to receive(:make_move).with(first_player)
        game.play_round
      end

      xit 'assigns @second_player to next_turn_player' do
        game.play_round
        expect(game.instance_variable_get(:@next_turn_player)).to eq(second_player)
      end
    end

    context 'when it is third round and @second_player is playing' do
      subject(:game) { described_class.new }
      let(:player1) { instance_double(Players, name: 'Greg', symbol: "\u26AA") }
      let(:player2) { instance_double(Players, name: 'Tim', symbol: "\u26AB") }
      let(:first_player) { player1 }
      let(:second_player) { player2 }
      let(:next_turn_player) { second_player }

      before do
        game.instance_variable_set(:@player1, player1)
        game.instance_variable_set(:@player2, player2)
        game.instance_variable_set(:@first_player, first_player)
        game.instance_variable_set(:@second_player, second_player)
        game.instance_variable_set(:@next_turn_player, next_turn_player)
      end

      it 'checks if next_turn_player variable is second_player' do
        expect(game.instance_variable_get(:@next_turn_player)).to eq(second_player)
      end

      xit 'calls #make_move with @second_player' do
        expect(game).to receive(:make_move).with(second_player)
        game.play_round
      end

      xit 'assigns @first_player to next_turn_player' do
        game.play_round
        expect(game.instance_variable_get(:@next_turn_player)).to eq(first_player)
      end
    end
  end

  describe '#make_move' do
    context 'when called with first_player' do
      subject(:game) { described_class.new }
      let(:player) { instance_double(Players, name: 'Tim', symbol: "\u26AA") }

      before do
        game.instance_variable_set(:@player, player)
      end
      
      xit 'asks player which column he choses' do
        expect(game).to receive(:puts).with("#{player.name} which column do you pick? From 1 - 7")
        game.make_move(player)
      end

      xit 'checks if column has enought room' do
        
      end

      xit 'throws pin in chosen column' do
        
      end
    end
  end
end