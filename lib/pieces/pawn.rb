# frozen_string_literal: true

require_relative 'piece'

# pawn representation--inherits from Piece
class Pawn < Piece
  def initialize(color:)
    super(color: color)
    @moves = [[1, 0], [2, 0]] if color == 'w'
    @moves = [[-1, 0], [-2, 0]] if color == 'b'
  end

  def capture_moves
    return [[1, -1], [1, 1]] if color == 'w'

    [[-1, -1], [-1, 1]] if color == 'b'
  end

  def moves
    return @moves if times_moved < 1

    [[1, 0]] if color == 'w'
    [[-1, 0]] if color == 'b'
  end
end
