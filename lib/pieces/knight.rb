# frozen_string_literal: true

require_relative 'piece'

# knight class
class Knight < Piece
  def initialize(color:)
    super(color: color)
    @moves = [[1, 2], [2, 1], [2, -1], [1, -2],
              [-1, 2], [-2, 1], [-2, -1], [-1, -2]]
  end
end
