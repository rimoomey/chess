# frozen_string_literal: true

require_relative 'piece'

# pawn representation--inherits from Piece
class Pawn < Piece

  def initialize(x:, y:, color:)
    super(x: x, y: y, color: color)
    @moves = [[0, 1], [0, 2], [-1, 1], [1, 1]]
  end

  def move(x:, y:)
    super(x: x, y: y)
    @moves = [[0, 1], [-1, 1], [1, 1]]
  end
end
