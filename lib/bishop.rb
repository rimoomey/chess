# frozen_string_literal: true

require_relative 'piece'

# bishop for chess
class Bishop < Piece
  def initialize(x:, y:, color:)
    super(x: x, y: y, color: color)
    @moves = bishop_moves
  end

  private

  def bishop_moves
    [[1, 1], [2, 2], [3, 3], [4, 4],
     [5, 5], [6, 6], [7, 7], [-1, 1],
     [-2, 2], [-3, 3], [-4, 4], [-5, 5],
     [-6, 6], [-7, 7], [1, -1], [2, -2],
     [3, -3], [4, -4], [5, -5], [6, -6],
     [7, -7], [-1, -1], [-2, -2], [-3, -3],
     [-4, -4], [-5, -5], [-6, -6], [-7, -7]]
  end
end
