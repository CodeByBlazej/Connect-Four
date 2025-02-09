require_relative '../sort'
require 'pry-byebug'

class Board
  attr_reader :board, :winner

  def initialize board
    @board = board
    @winner = false
  end

  def display_board
    board.each do |row|
      print '|'
      print row.map { |cell| cell.nil? ? ' |' : cell }.join
      puts "\n---------------"
    end
  end

  def check_row_score(player)
    board.each do |row|
      row.each_cons(4) do |four|
        if four.all? { |el| el == player.symbol }
          puts "#{player.name} WON THE GAME!"
          @winner = true
          return true
        end
      end
    end
    false
  end

  def check_column_score(player)
    (0...board.first.size).each do |index|
       board.each_cons(4) do |four|
        if four.all? { |el| el[index] == player.symbol }
          puts "#{player.name} WON THE GAME!"
          @winner = true
          return true
        end
      end
    end
  end
end