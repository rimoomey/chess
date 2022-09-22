# frozen_string_literal: true

require_relative 'piece'

# rook piece for chess
class Rook < Piece
  def initialize(x:, y:, color:)
    super(x: x, y: y, color: color)
    @moves = rook_moves
  end

  private

  def rook_moves
    [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5],
     [0, 6], [0, 7], [0, -1], [0, -2], [0, -3],
     [0, -4], [0, -5], [0, -6], [0, -7], [1, 0],
     [2, 0], [3, 0], [4, 0], [5, 0], [6, 0],
     [7, 0], [-1, 0], [-2, 0], [-3, 0], [-4, 0],
     [-5, 0], [-6, 0], [-7, 0]]
  end
end
