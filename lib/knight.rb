# frozen_string_literal: true

# knight class
class Knight < Piece
  def initialize(x:, y:, board:, color:)
    super(x: x, y: y, board: board, color: color)
    @moves = [[1, 2], [2, 1], [2, -1], [1, -2],
              [-1, 2], [-2, 1], [-2, -1], [-1, -2]]
  end
end
