# frozen_string_literal: true

# king piece
class King < Piece
  def initialize(x:, y:, color:)
    super(x: x, y: y, color: color)
    @moves = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]]
  end
end
