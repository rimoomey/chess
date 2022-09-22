# frozen_string_literal: true

# module which controls movement on the board
module Movement
  def possible_moves(piece:)
    possibles = []
    piece.moves.each do |move|
      possible_move_x = piece.current_space[0] + move[0]
      possible_move_y = piece.current_space[1] + move[1]
      possibles.push([possible_move_x, possible_move_y]) if
                        in_bounds?(x: possible_move_x, y: possible_move_y)
    end
    possibles
  end
end
