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
    select_players_names_and_colors
  end

  def select_players_names_and_colors
    puts "Select first player's name"
    @player1_name = gets.chomp
    puts "Select player's color"
    @player1_color = gets.chomp
    puts "Select second player's name"
    @player2_name = gets.chomp
    puts "Select player's color"
    @player2_color = gets.chomp

    @player1 = Players.new(@player1_name, @player1_color)
    @player2 = Players.new(@player2_name, @player2_color)
  end

  def introduction
    puts <<~HEREDOC

    Welcome to Connect Four Game! 

    Please select user names as well as their colors!

    HEREDOC
  end
end