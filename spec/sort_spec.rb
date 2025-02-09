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
end