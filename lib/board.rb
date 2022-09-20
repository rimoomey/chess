# frozen_string_literal: true

# class to represent a chess board
class Board
  attr_reader :pieces, :dimensions

  def initialize(x_size: 8, y_size: 8)
    @pieces = []
    @dimensions = [x_size, y_size]
  end

  def in_bounds?(coords)
    coords[0].positive? && coords[0] <= dimensions[0] && coords[1].positive? &&
      coords[1] <= dimensions[1]
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
end
