# frozen_string_literal: true

# class to represent a chess board
class Board
  attr_reader :pieces, :dimensions

  def initialize(x_size: 8, y_size: 8)
    @pieces = []
    @dimensions = [x_size, y_size]
  end

  def in_bounds?(x:, y:)
    x.positive? && x <= dimensions[0] && y.positive? &&
      y <= dimensions[1]
  end

  def occupied?(x:, y:)
    pieces.each do |piece|
      return true if piece.current_space == [x, y]
    end
    false
  end

  def add_piece(piece:)
    @pieces.push(piece)
  end

  def move_piece(piece:, x:, y:)
    piece.move(x: x, y: y) unless occupied?(x: x, y: y) || !in_bounds?(x: x, y: y)
  end
end
