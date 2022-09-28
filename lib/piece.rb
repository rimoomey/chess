# frozen_string_literal: true

# superclass for a chess piece
class Piece
  attr_reader :current_space, :moves, :color

  def initialize(x:, y:, color:)
    @current_space = [x, y]
    @color = color
    @moves = []
  end

  def move(x:, y:)
    @current_space = [x, y]
  end

  def ==(other)
    self.class.name == other.class.name &&
      current_space == other.current_space &&
      color == other.color
  end
end
