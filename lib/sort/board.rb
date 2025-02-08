require_relative '../sort'

class Board
  attr_reader :board

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
end