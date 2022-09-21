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

  def possible_moves
    possibles = []
    moves.each do |move|
      possible_move_x = current_space[0] + move[0]
      possible_move_y = current_space[1] + move[1]
      possibles.push([possible_move_x, possible_move_y]) if
                        board.in_bounds?(x: possible_move_x, y: possible_move_y)
    end
    possibles
  end

  def move(x:, y:)
    @current_space = [x, y]
  end
end
