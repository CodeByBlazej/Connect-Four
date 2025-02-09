require_relative '../sort'


class Players
  attr_reader :name, :symbol
  
  def initialize (name, symbol)
    @name = name
    @symbol = symbol
  end
end