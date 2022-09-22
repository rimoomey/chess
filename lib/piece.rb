# frozen_string_literal: true

require_relative 'board'

# superclass for a chess piece
class Piece
  attr_reader :current_space, :moves, :board, :color

  def initialize(x:, y:, board:, color:)
    @current_space = [x, y]
    @board = board
    @color = color
    @moves = []
  end

  def move(x:, y:)
    @current_space = [x, y]
  end

  def ==(other)
    self.class.name == other.class.name &&
      current_space == other.current_space &&
      color == other.color
  end
end
