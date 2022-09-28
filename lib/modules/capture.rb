# frozen_string_literal: true

require_relative '../board'

# module to add capturing mechanics to board
module Capture
  def capturable_pieces(piece:)
    #return pieces.map { |piec| [piec.current_space[0], piec.current_space[1]] } unless pieces.empty?
  end

  def capturable?(piece:, target_x:, target_y:)
    capturable = vertical_check(piece: piece, target: [target_x, target_y])
    capturable
  end

  private

  def vertical_check(piece:, target:)
    column = vertical(piece: piece)

    return unless column.include?(target)

    i = column.find_index(target)
    (1...i).each do |piece_index|
      pieces.each do |curr_piece|
        return false if column[piece_index] == curr_piece.current_space
      end
    end
    occupied?(x: target[0], y: target[1])
  end

  def vertical(piece:)
    moves = []
    (-8..8).each do |delta|
      if piece.moves.include?([delta, 0]) && !delta.zero?
        possible_movement = [piece.current_space[0] + delta, piece.current_space[1]]
        moves.push(possible_movement) if in_bounds?(x: possible_movement[0], y: possible_movement[1])
      end
    end
    moves
  end

  def horizontal(piece:)
    moves = []
    (-8..8).each do |delta|
      if piece.moves.include?([0, delta]) && !delta.zero?
        possible_movement = [piece.current_space[0], piece.current_space[1] + delta]
        moves.push(possible_movement) if in_bounds?(x: possible_movement[0], y: possible_movement[1])
      end
    end
    moves
  end

  def diagonals(piece:)
    moves = []
    (-8..8).each do |delta|
      moves += diagonal_right(piece: piece, delta: delta)
      moves += diagonal_left(piece: piece, delta: delta)
    end
    moves
  end

  def diagonal_right(piece:, delta:)
    moves = []
    if piece.moves.include?([delta, delta]) && !delta.zero?
      possible_movement = [piece.current_space[0] + delta, piece.current_space[1] + delta]
      moves.push(possible_movement) if in_bounds?(x: possible_movement[0], y: possible_movement[1])
    end
    moves
  end

  def diagonal_left(piece:, delta:)
    moves = []
    if piece.moves.include?([delta, delta]) && !delta.zero?
      possible_movement = [piece.current_space[0] - delta, piece.current_space[1] + delta]
      moves.push(possible_movement) if in_bounds?(x: possible_movement[0], y: possible_movement[1])
    end
    moves
  end
end
