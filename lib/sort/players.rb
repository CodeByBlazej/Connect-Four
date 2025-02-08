require_relative '../sort'


class Players
  attr_reader :name, :color
  
  def initialize (name, color)
    @name = name
    @color = color
  end
end