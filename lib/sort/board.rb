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
      print row.join
      puts "\n----------------------"
    end
  end

  def check_row_score(player)
    board.each do |row|
      row.each_cons(4) do |four|
        if four.all? { |el| el == "#{player.symbol}|" }
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
        if four.all? { |el| el[index] == "#{player.symbol}|" }
          puts "#{player.name} WON THE GAME!"
          @winner = true
          return true
        end
      end
    end
    
    false
  end

  def check_diagonal_score(player)
    rows = board.size
    cols = board.first.size
    diagonals = []

    (0...cols).each do |start_col|
      diagonal = []
      row = 0
      col = start_col
      
      while row < rows && col < cols
        diagonal << board[row][col]
        row += 1
        col += 1
      end

      diagonals << diagonal if diagonal.size >= 4
    end
    
    (1...rows).each do |start_row|
      diagonal = []
      row = start_row
      col = 0

      while row < rows && col < cols
        diagonal << board[row][col]
        row += 1
        col += 1
      end

      diagonals << diagonal if diagonal.size >= 4
    end

    diagonals.each do |arr|
      arr.each_cons(4) do |four|
        if four.all? { |el| el == "#{player.symbol}|" }
          puts "#{player.name} WON THE GAME!"
          @winner = true
          return true
        end
      end
    end

    false
  end

  def check_anti_diagonal_score(player)
    rows = board.size
    cols = board.first.size
    diagonals = []

    (0...cols).each do |start_col|
      diagonal = []
      row = 0
      col = start_col

      while row < rows && col < cols
        diagonal << board[row][cols - 1 - col]
        row += 1
        col += 1
      end
      
      diagonals << diagonal if diagonal.size >= 4
    end

    (1...rows).each do |start_row|
      diagonal = []
      row = start_row
      col = 0

      while row < rows && col < cols
        diagonal << board[row][cols - 1 - col]
        row += 1
        col += 1
      end

      diagonals << diagonal if diagonal.size >= 4
    end

    diagonals.each do |arr|
      arr.each_cons(4) do |four|
        if four.all? { |el| el == "#{player.symbol}|" }
          puts "#{player.name} WON THE GAME!"
          @winner = true
          return true
        end
      end
    end
    
    false
  end
end