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
        board.board[0][0] = "\u26AA"
        board.board[0][1] = "\u26AA"
        board.board[0][2] = "\u26AA"
        board.board[0][3] = "\u26AA"
        allow(board).to receive(:puts)
      end

      it 'returns true' do
        expect(board).to receive(:puts).with("#{player.name} WON THE GAME!").once
        board.check_row_score(player)
      end

      it 'set winner to be true' do
        result = board.check_row_score(player)
        expect(result).to be_truthy
        expect(board.winner).to eq(true)
      end
    end
  end
end