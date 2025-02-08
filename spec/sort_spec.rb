require_relative '../lib/sort'

describe Game do
  describe '#select_players_names_and_colors' do
    context 'when user gives 2 names and 2 colors' do
      subject(:game) { described_class.new }
      let(:players) { instance_double(Players) }

      before do
        player1_name = 'Tom'
        player1_color = 'Red'
        player2_name = 'Blazej'
        player2_color = 'Green'
        allow(game).to receive(:gets).and_return(player1_name, player1_color, player2_name, player2_color)
        allow(game).to receive(:puts)
      end

      it 'creates 2 objects' do
        expect(Players).to receive(:new).twice
        game.select_players_names_and_colors
      end
    end
  end
end