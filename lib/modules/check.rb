# frozen_string_literal: true

# module for board class to determine if a king is in check
module Check
  def check?(location:)
    game_state.each_with_index do |row, row_num|
      row.each_with_index do |piece, col_num|
        next if piece.instance_of?(Integer)

        return true if possible_captures(piece: piece, place: [row_num, col_num]).include?(location)
      end
    end
    false
  end
end
