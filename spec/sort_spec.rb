require_relative '../lib/sort'

describe Game do
  subject(:game) { described_class.new }
  let(:players) { instance_double(Players) }
  let(:board) { instance_double(Board, winner: false) }
  let(:board_array) { Array.new(6) { Array.new(7) } }
  let(:player1) { instance_double(Players, name: 'Tom', symbol: "\u26AA") }
  let(:player2) { instance_double(Players, name: 'Bob', symbol: "\u26AB") }

  describe '#select_players_names_and_symbols' do
    context 'when user gives 2 names' do

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
      let(:player1_symbol) { "\u26AA" }

      before do
        game.instance_variable_set(:@board, board)
        game.instance_variable_set(:@player1_symbol, player1_symbol)

        allow(board).to receive(:board).and_return(board_array)

        board.board.map! do |row|
          row.map { |el| el = "#{player1_symbol}|" }
        end
      end

      it 'returns TRUE' do
        result = game.board_full?
        expect(result).to eq(true)
      end
    end

    context 'when board is NOT full' do
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

      it 'assigns @second_player to next_turn_player' do
        expect(game).to receive(:make_move).with(first_player)
        game.play_round
        expect(game.instance_variable_get(:@next_turn_player)).to eq(second_player)
      end
    end

    context 'when it is second round and @first_player is playing' do

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

      it 'assigns @second_player to next_turn_player' do
        expect(game).to receive(:make_move).with(first_player)
        game.play_round
        expect(game.instance_variable_get(:@next_turn_player)).to eq(second_player)
      end
    end

    context 'when it is third round and @second_player is playing' do

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

      it 'calls #make_move with @second_player' do
        expect(game).to receive(:make_move).with(second_player)
        game.play_round
      end

      it 'assigns @first_player to next_turn_player' do
        expect(game).to receive(:make_move).with(second_player)
        game.play_round
        expect(game.instance_variable_get(:@next_turn_player)).to eq(first_player)
      end
    end
  end

  describe '#make_move' do

    before do
      allow(game).to receive(:puts)
      allow(game).to receive(:gets).and_return('4')
      allow(game).to receive(:column_selected_empty?).and_return(true)
    end
      
    it 'it calls insert_coin and sets @column_selected to 3' do
      expect(game).to receive(:insert_coin).with(player1)        
      game.make_move(player1)
      expect(game.instance_variable_get(:@column_selected)).to eq(3)
    end
  end

  describe '#column_selected_empty?' do
    context 'when column is empty' do

      before do
        game.instance_variable_set(:@board, board)
        allow(board).to receive(:board).and_return(board_array)
        allow(game).to receive(:column_selected).and_return(3)

        board_array.each do |row|
          row.map! { |el| el = '  |' }
        end
      end

      it 'returns TRUE' do
        result = game.column_selected_empty?
        expect(result).to eq(true)
      end
    end

    context 'when column is full' do

      before do
        game.instance_variable_set(:@board, board)
        allow(board).to receive(:board).and_return(board_array)
        allow(game).to receive(:column_selected).and_return(3)

        board_array.map { |el| el[3] == '\u26AA' }
      end

      it 'returns FALSE' do
        result = game.column_selected_empty?
        expect(result).to eq(false)  
      end
    end
  end

  describe '#insert_coin' do
    context 'when column is empty' do
      let(:player1_symbol) { "\u26AA" }
      let(:player2_symbol) { "\u26AB" }

      before do
        game.instance_variable_set(:@board, board)
        game.instance_variable_set(:@player1, player1)
        game.instance_variable_set(:@player1_symbol, player1_symbol)
        game.instance_variable_set(:@player2_symbol, player2_symbol)

        allow(board).to receive(:board).and_return(board_array)
        allow(board).to receive(:display_board)
        allow(game).to receive(:column_selected).and_return(3)

        board_array.each do |row|
          row.map! { |el| el = '  |' }
        end
      end

      it 'puts coin at the end' do
        game.insert_coin(player1)
        expect(board_array.last[3]).to eq("\u26AA|")
      end
    end

    context 'when column has 1 coin at the same bottom' do
      let(:player1_symbol) { "\u26AA" }
      let(:player2_symbol) { "\u26AB" }

      before do
        game.instance_variable_set(:@board, board)
        game.instance_variable_set(:@player1, player1)
        game.instance_variable_set(:@player1_symbol, player1_symbol)
        game.instance_variable_set(:@player2_symbol, player2_symbol)

        allow(board).to receive(:board).and_return(board_array)
        allow(board).to receive(:display_board)
        allow(game).to receive(:column_selected).and_return(3)

        board_array.each do |row|
          row.map! { |el| el = '  |' }
        end

        board_array.last[3] = "\u26AA|"
      end

      it 'puts the coin at the second slot' do
        game.insert_coin(player1)
        expect(board_array[5][3]).to eq("\u26AA|")
      end
    end
  end
end