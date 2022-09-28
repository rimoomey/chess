# frozen_string_literal: true

require_relative 'modules/movement'

# class to represent a chess board
class Board
  include Movement

  attr_reader :pieces

  DIMENSIONS = [8, 8].freeze

  def initialize
    @pieces = []
  end

  def in_bounds?(x:, y:)
    x.positive? && x <= DIMENSIONS[0] && y.positive? &&
      y <= DIMENSIONS[1]
  end

  def occupied?(x:, y:)
    pieces.each do |piece|
      return true if piece.current_space == [x, y]
    end
    false
  end

  def add_piece(piece:)
    @pieces.push(piece)
  end

  def move_piece(piece:, x:, y:)
    piece.move(x: x, y: y) unless occupied?(x: x, y: y) ||
                                  !in_bounds?(x: x, y: y) ||
                                  piece_blocking_movement?(x: piece.current_space[0],
                                                           y: piece.current_space[0],
                                                           target_x: x, target_y: y)
  end
end
