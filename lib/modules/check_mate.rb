require_relative './check'

# module for board class to calculate check_mates
module CheckMate
  include Check

  def check_mate?(king:, location:)
    return false unless game_state[location[0]][location[1]].instance_of?(King)
    return false unless check?(location: location)

    possible_captures(piece: king, place: location).each do |capture|
      return false unless check?(location: capture)
    end

    possible_moves(piece: king, place: location).each do |move|
      # add the king to that potential move to see if it would be in check, remove afterwards
      add_piece(piece: king, location: move)
      unless check?(location: move)
        add_piece(piece: 0, location: move)
        return false
      end

      add_piece(piece: 0, location: move)
    end

    true
  end
end
