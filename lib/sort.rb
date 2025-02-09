require_relative 'sort/board'
require_relative 'sort/players'


class Game
  # attr_reader :player1_name, :player1_color, :player2_name, :player2_color

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
    @board.display_board
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

  def introduction
    puts <<~HEREDOC

    Welcome to Connect Four Game! 

    Please select user names as well as their colors!

    HEREDOC
  end
end