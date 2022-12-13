# frozen_string_literal: true

# superclass for a chess piece
class Piece
  attr_reader :current_space, :moves, :color

  def initialize(color:)
    @color = color
    @moves = []
  end

  def capture_moves
    moves
  end

  def ==(other)
    self.class.name == other.class.name && color == other.color
  end
end
