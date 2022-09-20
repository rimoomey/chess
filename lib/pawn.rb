# frozen_string_literal: true

require_relative 'piece'

# pawn representation--inherits from Piece
class Pawn < Piece
  def initialize(x:, y:, board:, color:)
    super(x: x, y: y, board: board, color: color)
    @moves = [[0, 1], [0, 2], [-1, 1], [1, 1]]
  end
end
