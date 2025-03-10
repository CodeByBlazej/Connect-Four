require_relative 'sort/board'
require_relative 'sort/players'
require 'pry-byebug'


class Game
  attr_reader :player1_name, :player1_symbol, :player2_name, :player2_symbol, :player1, :player2, :board, :first_player, :second_player, :next_turn_player, :column_selected

  def initialize
  end

  def play_game
    introduction
    select_players_names_and_symbols
    create_board
    @board.display_board
    select_which_player_plays_first
    play_round until somebody_wins? || board_full?
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
    board.board.each do |row|
      row.map! { |el| el = '  |' }
    end
  end

  def select_which_player_plays_first
    puts "Which one of you wants to play first? Please type 'player 1' or 'player 2'"
    answer = gets.chomp
    
    until answer == 'player 1' || answer == 'player 2' do
      puts "I'm sorry, it looks like you made a typo. Please write again 'player 1' or 'player 2'"
      answer = gets.chomp
    end

    if answer == 'player 1'
      @first_player = player1
      @second_player = player2
    else
      @first_player = player2
      @second_player = player1
    end
  end

  def play_round
    if next_turn_player == nil || next_turn_player == first_player
      make_move(first_player)
      @next_turn_player = second_player
    else
      make_move(second_player)
      @next_turn_player = first_player
    end
  end

  def make_move(player)
    puts "#{player.name} which column do you pick? From 1 - 7"
    user_input = gets.chomp.to_i

    until (1..7).include?(user_input) do
      puts "Looks like you made a typo. Select number from 1 - 7"
      user_input = gets.chomp.to_i
    end

    @column_selected = user_input - 1

    until column_selected_empty? do
      puts "This column is already full! Please select another one..."
      user_input = gets.chomp.to_i

      until (1..7).include?(user_input) do
        puts "Looks like you made a typo. Select number from 1 - 7"
        user_input = gets.chomp.to_i
      end

      @column_selected = user_input - 1
    end
    
    insert_coin(player)
  end

  def column_selected_empty?
    board.board.any? { |row| row[column_selected] == '  |' ? true : false }
  end

  def insert_coin(player)
    column = board.board.map { |el| el[column_selected] }
    first_free_slot_index = column.find_index { |el| el.start_with?(player1_symbol) || el.start_with?(player2_symbol) }

    if first_free_slot_index.nil? 
      board.board.last[column_selected] = "#{player.symbol}|"
    else
      board.board[first_free_slot_index - 1][column_selected] = "#{player.symbol}|"
    end

    board.display_board
  end

  def somebody_wins?
    board.check_row_score(player1) || 
    board.check_row_score(player2) ||
    board.check_column_score(player1) ||
    board.check_column_score(player2) ||
    board.check_diagonal_score(player1) ||
    board.check_diagonal_score(player2) ||
    board.check_anti_diagonal_score(player1) ||
    board.check_anti_diagonal_score(player2)
  end

  def board_full?
    board.board.flatten.all? { |el| el == "#{player1_symbol}|" || el == "#{player2_symbol}|" }
  end

  def introduction
    puts <<~HEREDOC

    Welcome to Connect Four Game! 

    Please select user names as well as their colors!

    HEREDOC
  end
end