# frozen_string_literal: true

# class to represent a chess board
class Board
  include Movement
  include Capture
  include Check
  include CheckMate
  include StaleMate

  attr_accessor :game_state

  DIMENSIONS = [8, 8].freeze

  def initialize
    @game_state = empty_board
  end

  def in_bounds?(point:)
    !point[0].negative? && point[0] < DIMENSIONS[0] && !point[1].negative? &&
      point[1] < DIMENSIONS[1]
  end

  def occupied?(point:)
    return false if game_state[point[0]][point[1]].eql?(0)

    true
  end

  def add_piece(piece:, location: [0, 0])
    @game_state[location[0]][location[1]] = piece
  end

  def move_piece(start_loc:, end_loc:)
    piece = game_state[start_loc[0]][start_loc[1]]
    return if piece.eql?(0)

    return unless possible_moves(piece: piece, place: start_loc).include?(end_loc)

    piece.moved_once
    @game_state[end_loc[0]][end_loc[1]] = piece
    @game_state[start_loc[0]][start_loc[1]] = 0
  end

  def capture_piece(captor_loc:, captive_loc:)
    captor = game_state[captor_loc[0]][captor_loc[1]]
    return if captor.eql?(0)

    return unless possible_captures(piece: captor, place: captor_loc).include?(captive_loc)

    captor.moved_once
    @game_state[captive_loc[0]][captive_loc[1]] = captor
    @game_state[captor_loc[0]][captor_loc[1]] = 0
  end

  private

  def empty_board
    one_row = [0, 0, 0, 0, 0, 0, 0, 0]
    board = []
    8.times { board.push(one_row.clone) }
    board
  end
end
