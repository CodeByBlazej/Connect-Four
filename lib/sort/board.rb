require_relative '../sort'
require 'pry-byebug'

class Board
  attr_reader :board, :winner

  def initialize board
    @board = board
  end

  def display_board
    board.each do |row|
      print '|'
      print row.map { |cell| cell.nil? ? ' |' : cell }.join
      puts "\n---------------"
    end
  end

  def check_row_score(player)
    board.each do |scores|
      consecutive_elements = []

      scores.each_cons(4) { |score| consecutive_elements << score }
      consecutive_elements.any? do |elements|
        if elements.all? { |el| el == player.symbol }
          puts "#{player.name} WON THE GAME!"
          @winner = true
        end
      end
    end
  end
end