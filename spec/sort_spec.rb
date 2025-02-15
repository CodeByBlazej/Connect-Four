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
    let(:board) { class_double(Board) }

    it 'creates object for the board' do
      expect(Board).to receive(:new).with(Array.new(6) { Array.new(7) })
      game.create_board
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

      it 'returns true' do
        result = game.board_full?
        expect(result).to eq(true)
      end
    end
  end
end