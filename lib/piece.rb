# frozen_string_literal: true

# superclass for a chess piece
class Piece
  attr_reader :current_space, :moves

  def initialize(x:, y:)
    @current_space = [x, y]
    @moves = []
  end
end
