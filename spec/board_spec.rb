require_relative '../lib/sort/board'

describe Board do
  describe '#display_board' do
    subject(:board) { described_class.new(Array.new(6) { Array.new(7) }) }

    it 'has a 7 x 6 grid' do
      expect(board.board[0].size).to eq(7)
      expect(board.board.size).to eq(6)
      board.display_board
    end
  end

  describe '#check_row_score' do
    context 'when 4 fields in a row are the same' do
      subject(:board) { described_class.new(Array.new(6) { Array.new(7) }) }
      let(:player) { instance_double(Players, name: 'Tom', symbol: "\u26AA") }

      before do
        board.board[0][0] = player.symbol
        board.board[0][1] = player.symbol
        board.board[0][2] = player.symbol
        board.board[0][3] = player.symbol
        allow(board).to receive(:puts)
      end

      it 'returns true and puts a message' do
        expect(board).to receive(:puts).with("#{player.name} WON THE GAME!").once
        board.check_row_score(player)
      end

      it 'sets winner to be true' do
        result = board.check_row_score(player)
        expect(result).to be_truthy
        expect(board.winner).to eq(true)
      end
    end

    context 'when fields in a rows are different and there is NO winner' do
      subject(:board) { described_class.new(Array.new(6) { Array.new(7) }) }
      let(:player) { instance_double(Players, name: 'Blazej', symbol: "\u26AB") }

      before do
        board.board[0][0] = player.symbol
        board.board[0][1] = player.symbol
        board.board[0][4] = player.symbol
        board.board[0][7] = player.symbol
        allow(board).to receive(:puts)
      end

      it 'does NOT return true and does NOT puts a message' do
        expect(board).not_to receive(:puts).with("#{player.name} WON THE GAME!")
        board.check_row_score(player)
      end

      it 'does NOT set winner to be true' do
        result = board.check_row_score(player)
        expect(result).not_to be_truthy
        expect(board.winner).to eq(false)
      end
    end
  end

  describe '#check_column_score' do
    context 'when 4 scores in any row are the same' do
      subject(:board) { described_class.new(Array.new(6) { Array.new(7) }) }
      let(:player) { instance_double(Players, name: 'Tom', symbol: "\u26AA") }

      before do
        board.board[0][0] = player.symbol
        board.board[1][0] = player.symbol
        board.board[2][0] = player.symbol
        board.board[3][0] = player.symbol
        allow(board).to receive(:puts)
      end

      it 'returns true and puts a message' do
        expect(board).to receive(:puts).with("#{player.name} WON THE GAME!")
        board.check_column_score(player)
      end

      it 'sets winner to be true' do
        result = board.check_column_score(player)
        expect(result).to be_truthy
        expect(board.winner).to eq(true)
      end
    end

    context 'when fields in a column are different and there is NO winner' do
      subject(:board) { described_class.new(Array.new(6) { Array.new(7) }) }
      let(:player) { instance_double(Players, name: 'Eric', symbol: "\u26AB") }

      before do
        board.board[0][0] = player.symbol
        board.board[1][1] = player.symbol
        board.board[2][0] = player.symbol
        board.board[3][0] = player.symbol
        allow(board).to receive(:puts)
      end

      it 'does NOT returns true and does NOT puts a message' do
        expect(board).not_to receive(:puts).with("#{player.name} WON THE GAME!")
        board.check_column_score(player)
      end

      it 'does NOT set winner to be true' do
        result = board.check_column_score(player)
        expect(result).not_to be_truthy
        expect(board.winner).to eq(false)
      end
    end
  end

  describe '#check_diagonal_score' do
    context 'when any 4 diagonal scores are the same' do
      subject(:board) { described_class.new(Array.new(6) { Array.new(7) }) }
      let(:player) { instance_double(Players, name: 'Ian', symbol: "\u26AA") }

      before do
        board.board[0][0] = player.symbol
        board.board[1][1] = player.symbol
        board.board[2][2] = player.symbol
        board.board[3][3] = player.symbol
        allow(board).to receive(:puts)
      end

      it 'returns true and puts a message' do
        expect(board).to receive(:puts).with("#{player.name} WON THE GAME!")
        board.check_diagonal_score(player)
      end

      it 'sets winner to be true' do
        result = board.check_diagonal_score(player)
        expect(result).to be_truthy
        expect(board.winner).to eq(true)
      end
    end

    context 'when there is NOT 4 scores in diagonal' do
      subject(:board) { described_class.new(Array.new(6) { Array.new(7)} ) }
      let(:player) { instance_double(Players, name: 'Tim', symbol: "\u26AB") }

      before do
        board.board[0][0] = player.symbol
        board.board[1][1] = player.symbol
        board.board[2][3] = player.symbol
        board.board[3][3] = player.symbol
        allow(board).to receive(:puts)
      end

      it 'does NOT return true and does NOT puts a message' do
        expect(board).not_to receive(:puts).with("#{player.name} WON THE GAME!")
        board.check_diagonal_score(player)
      end

      it 'does NOT set winner to be true' do
        result = board.check_diagonal_score(player)
        expect(result).not_to be_truthy
        expect(board.winner).to eq(false)
      end
    end
  end

  describe "#check_anti_diagonal_score" do
    context 'when any 4 anti diagonal scores are the same' do
      subject(:board) { described_class.new(Array.new(6) { Array.new(7) }) }
      let(:player) { instance_double(Players, name: 'Terry', symbol: "\u26AB") }

      before do
        board.board[0][3] = player.symbol
        board.board[1][2] = player.symbol
        board.board[2][1] = player.symbol
        board.board[3][0] = player.symbol
        allow(board).to receive(:puts)
      end

      it 'returns true and puts a message' do
        expect(board).to receive(:puts).with("#{player.name} WON THE GAME!")
        board.check_anti_diagonal_score(player)
      end
    end
  end
end