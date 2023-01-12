# frozen_string_literal: true

# superclass for a chess piece
class Piece
  attr_reader :times_moved, :moves, :color

  def initialize(color:)
    @color = color
    @times_moved = 0
    @moves = []
  end

  def moved_once
    @times_moved += 1
  end

  def decrement_moves
    @times_moved -= 1
  end

  def capture_moves
    moves
  end

  def ==(other)
    instance_of?(other.class) && color == other.color
  end
end
