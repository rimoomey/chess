# frozen_string_literal: true

require_relative 'board'

# superclass for a chess piece
class Piece
  attr_reader :current_space, :moves, :board

  def initialize(x:, y:, board:)
    @current_space = [x, y]
    @board = board
    @moves = []
  end

  def possible_moves
    possibles = []
    moves.each do |move|
      possible_move = [current_space[0] + move[0], current_space[1] + move[1]]
      possibles.push(possible_move) if board.in_bounds?(possible_move)
    end
    possibles
  end
end
