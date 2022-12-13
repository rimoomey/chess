# frozen_string_literal: true

require_relative 'piece'

# king piece
class King < Piece
  def initialize(color:)
    super(color: color)
    @moves = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]]
  end
end
