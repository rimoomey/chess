# frozen_string_literal: true

# module for board class to calculate stale_mates
module StaleMate
  include Check

  def stale_mate?(king:, location:)
    return false unless game_state[location[0]][location[1]].instance_of?(King)

    # for a stale mate, the king must not be in check
    return false if check?(location: location)

    # check each same-colored piece on the board to see if they can block the check
    game_state.each_with_index do |row, row_num|
      row.each_with_index do |piece, col_num|
        next if piece.instance_of?(Integer)
        next if location == [row_num, col_num]
        next if piece.color != king.color

        unless checkmate_not_blocked?(piece: piece, piece_location: [row_num, col_num], king: king, king_location: location)
          return false
        end
      end
    end

    # check the king to see if he can move out of check by a capture
    possible_captures(piece: king, place: location).each do |capture|
      piece = game_state[capture[0]][capture[1]]

      # perform the capture to see if it causes king to move out of check, undo afterwards
      capture_piece(captor_loc: location, captive_loc: capture)
      unless check?(location: capture)
        add_piece(piece: piece, location: capture)
        add_piece(piece: king, location: location)
        return false
      end
      add_piece(piece: piece, location: capture)
      add_piece(piece: king, location: location)
    end

    # check the king to see if he can move out of check by a non-capture
    possible_moves(piece: king, place: location).each do |move|
      # move the king to see if it would be in check, remove afterwards
      move_piece(start_loc: location, end_loc: move)
      unless check?(location: move)
        move_piece(start_loc: move, end_loc: location)
        return false
      end
      move_piece(start_loc: move, end_loc: location)
    end

    true
  end
end

private

def checkmate_not_blocked?(piece:, piece_location:, king_location:)
  unless not_block_by_capture?(king_location: king_location, current_piece: piece, current_piece_location: piece_location)
    return false
  end
  unless not_block_by_movement?(king_location: king_location, current_piece: piece, current_piece_location: piece_location)
    return false
  end

  true
end

def not_block_by_capture?(king_location:, current_piece:, current_piece_location:)
  possible_captures(piece: current_piece, place: current_piece_location).each do |capture|
    captured_piece = game_state[capture[0]][capture[1]]
    capture_piece(captor_loc: current_piece_location, captive_loc: capture)

    unless check?(location: king_location)
      add_piece(piece: captured_piece, location: capture)
      add_piece(piece: current_piece, location: current_piece_location)
      return false
    end
    add_piece(piece: captured_piece, location: capture)
    add_piece(piece: current_piece, location: current_piece_location)
  end
  true
end

def not_block_by_movement?(king_location:, current_piece:, current_piece_location:)
  possible_moves(piece: current_piece, place: current_piece_location).each do |move|
    move_piece(start_loc: current_piece_location, end_loc: move)

    unless check?(location: king_location)
      move_piece(start_loc: move, end_loc: current_piece_location)
      return false
    end
    move_piece(start_loc: move, end_loc: current_piece_location)
  end
  true
end
