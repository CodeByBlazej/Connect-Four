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
end