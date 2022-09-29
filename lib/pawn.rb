# frozen_string_literal: true

require_relative 'piece'

# pawn representation--inherits from Piece
class Pawn < Piece

  def initialize(color:)
    super(color: color)
    @moves = [[1, 0], [2, 0], [1, -1], [1, 1]] if color == 'w'
    @moves = [[-1, 0], [-2, 0], [-1, -1], [-1, 1]] if color == 'b'
  end

  def capture_moves
    [[1, -1], [1, 1]] if color == 'w'
    [[-1, -1], [-1, 1]] if color == 'b'
  end

  def fewer_moves
    @moves = [[0, 1], [-1, 1], [1, 1]]
  end
end
