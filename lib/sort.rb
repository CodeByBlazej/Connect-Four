require_relative 'sort/board'
require_relative 'sort/players'


class Game
  attr_reader :player1_name, :player1_symbol, :player2_name, :player2_symbol, :player1, :player2, :board

  def initialize
    # @player1_name = player1_name
    # @player1_color = player1_color
    # @player2_name = player2_name
    # @player2_color = player2_color
  end

  def play_game
    introduction
    select_players_names_and_symbols
    create_board
    # board.display board is only to check whats going on now
    @board.display_board
    #idea for next methods: 
    #play_round until somebody_wins? || board_full?
  end

  def select_players_names_and_symbols
    puts "Select first player's name"
    @player1_name = gets.chomp
    @player1_symbol = "\u26AA"
    puts "Select second player's name"
    @player2_name = gets.chomp
    @player2_symbol = "\u26AB"

    @player1 = Players.new(@player1_name, @player1_symbol)
    @player2 = Players.new(@player2_name, @player2_symbol)
  end

  def create_board
    @board = Board.new(Array.new(6) { Array.new(7) })
  end

  def somebody_wins?
    return false unless 
    board.check_row_score(player1) || 
    board.check_row_score(player2) ||
    board.check_column_score(player1) ||
    board.check_column_score(player2) ||
    board.check_diagonal_score(player1) ||
    board.check_diagonal_score(player2) ||
    board.check_anti_diagonal_score(player1) ||
    board.check_anti_diagonal_score(player2)
  end

  def introduction
    puts <<~HEREDOC

    Welcome to Connect Four Game! 

    Please select user names as well as their colors!

    HEREDOC
  end
end