# frozen_string_literal: true

require_relative 'modules/movement'
require_relative 'modules/capture'
require_relative 'modules/game_state'

# class to represent a chess board
class Board
  include Movement
  include Capture

  attr_reader :game_state

  DIMENSIONS = [8, 8].freeze

  def initialize
    @game_state = empty_board
  end

  def in_bounds?(x:, y:)
    !x.negative? && x < DIMENSIONS[0] && !y.negative? &&
      y < DIMENSIONS[1]
  end

  def occupied?(x:, y:)
    return false if game_state[x][y].eql?(0)

    true
  end

  def add_piece(piece:, location: [0, 0])
    @game_state[location[0]][location[1]] = piece
  end

  def move_piece(piece:, x:, y:)
    curr_loc = piece.current_space

    return if occupied?(x: x, y: y) || !in_bounds?(x: x, y: y) ||
              piece_blocking_movement?(x: piece.current_space[0], y: piece.current_space[0], target_x: x, target_y: y)

    @game_state[x][y] = piece
    @game_state[curr_loc[0]][curr_loc[1]] = 0
  end

  private

  def empty_board
    one_row = [0, 0, 0, 0, 0, 0, 0, 0]
    board = []
    8.times { board.push(one_row.clone) }
    board
  end
end
