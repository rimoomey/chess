# frozen_string_literal: true

# class to represent a chess board
class Board
  attr_reader :pieces, :dimensions

  def initialize(x: 8, y: 8)
    @pieces = []
    @dimensions = [x, y]
  end

  def in_bounds?(x_coord, y_coord)
    x_coord.positive? && x_coord <= dimensions[0] && y_coord.positive? &&
      y_coord <= dimensions[1]
  end
end
