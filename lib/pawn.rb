# frozen_string_literal: true

require_relative 'piece'

# pawn representation--inherits from Piece
class Pawn < Piece
  attr_reader :moved

  def initialize(x:, y:, color:)
    super(x: x, y: y, color: color)
    @moves = [[0, 1], [0, 2], [-1, 1], [1, 1]]
    @moved = false
  end

  def move(x:, y:)
    super(x: x, y: y)
    @moved = true
  end
end
