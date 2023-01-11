# frozen_string_literal: true

# module for board class to calculate check_mates
module CheckMate
  include Check

  def check_mate?(king:, location:)
    return false unless game_state[location[0]][location[1]].instance_of?(King)
    return false unless check?(location: location)

    # check each same-colored piece on the board to see if they can block the check
    game_state.each_with_index do |row, row_num|
      row.each_with_index do |piece, col_num|
        next if piece.instance_of?(Integer)
        next if location == [row_num, col_num]
        next if piece.color != king.color

        return false unless checkmate_not_blocked?(king: king, king_location: location)
      end
    end

    possible_captures(piece: king, place: location).each do |capture|
      piece = game_state[capture[0]][capture[1]]
      capture_piece(captor_loc: location, captive_loc: capture)
      unless check?(location: capture)
        add_piece(piece: piece, location: capture)
        add_piece(piece: king, location: location)
        return false
      end

      add_piece(piece: piece, location: capture)
    end

    possible_moves(piece: king, place: location).each do |move|
      # add the king to that potential move to see if it would be in check, remove afterwards
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

def checkmate_not_blocked?(king:, king_location:)
  game_state.each_with_index do |row, row_num|
    row.each_with_index do |piece, col_num|
      next if piece.instance_of?(Integer)
      next if king_location == [row_num, col_num]
      next if piece.color != king.color

      p piece

      unless not_block_by_capture?(king_location: king_location, current_piece: piece, current_piece_location: [row_num, col_num])
        return false
      end
      unless not_block_by_movement?(king_location: king_location, current_piece: piece, current_piece_location: [row_num, col_num])
        return false
      end

      possible_captures(piece: piece, place: [row_num, col_num]).each do |capture|
        captured_piece = game_state[capture[0], capture[1]]
        capture_piece(captor_loc: [row_num, col_num], captive_loc: capture)

        unless check?(location: king_location)
          add_piece(piece: captured_piece, location: capture)
          add_piece(piece: piece, location: [row_num, col_num])
          return false
        end
        add_piece(piece: captured_piece, location: capture)
        add_piece(piece: piece, location: [row_num, col_num])
      end

      possible_moves(piece: piece, place: [row_num, col_num]).each do |move|
        add_piece(piece: piece, location: move)
        add_piece(piece: 0, location: [row_num, col_num])

        unless check?(location: king_location)
          add_piece(piece: 0, location: move)
          add_piece(piece: piece, location: [row_num, col_num])
          return false
        end
        add_piece(piece: 0, location: move)
        add_piece(piece: piece, location: [row_num, col_num])
      end
    end
  end
  true
end

def not_block_by_capture?(king_location:, current_piece:, current_piece_location:)
  possible_captures(piece: current_piece, place: current_piece_location).each do |capture|
    captured_piece = game_state[capture[0], capture[1]]
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
    add_piece(piece: current_piece, location: move)
    add_piece(piece: 0, location: current_piece_location)

    unless check?(location: king_location)
      add_piece(piece: 0, location: move)
      add_piece(piece: current_piece, location: current_piece_location)
      return false
    end
    add_piece(piece: 0, location: move)
    add_piece(piece: current_piece, location: current_piece_location)
  end
  true
end
