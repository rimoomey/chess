# frozen_string_literal: true

# module which controls movement on the board
module Movement
  def possible_moves(piece:, place:)
    possibles = []
    piece.moves.each do |move|
      x1 = place[0]
      y1 = place[1]
      x2 = x1 + move[0]
      y2 = y1 + move[1]
      possibles.push([x2, y2]) if valid_move?(start_loc: [x1, y1], end_loc: [x2, y2])
    end
    possibles
  end

  def piece_blocking_movement?(start_loc:, end_loc:)
    spaces_to_check = spaces_between(start_loc,
                                     end_loc)

    spaces_to_check.each do |space|
      return true if occupied?(x: space[0], y: space[1])
    end
    false
  end

  private

  def valid_move?(start_loc:, end_loc:)
    in_bounds?(x: end_loc[0], y: end_loc[1]) && !piece_blocking_movement?(start_loc: start_loc, end_loc: end_loc)
  end

  def spaces_between(space1, space2)
    if space1[0] == space2[0] && space1[1] == space2[1]
      [space1[0], space1[1]]
    elsif space1[0] == space2[0]
      horizontal_spaces_between(space1, space2)
    elsif space1[1] == space2[1]
      y = space1[1]
      vertical_spaces_between(space1[0], space2[0], y)
    else
      diagonal_spaces_between(space1, space2)
    end
  end

  def horizontal_spaces_between(space1, space2)
    spaces_between = []
    ((space1[1] + 1)..space2[1]).each do |y_index|
      spaces_between.push([space1[0], y_index])
    end
    spaces_between
  end

  def vertical_spaces_between(x1, x2, y)
    spaces_between = []
    ((x1 + 1)..x2).each do |x|
      spaces_between.push([x, y])
    end
    spaces_between
  end

  def diagonal_spaces_between(space1, space2)
    spaces_between = []
    (-8..8).each do |shift|
      spaces_between += downward_diag(shift, space1, space2)
      spaces_between += upward_diag(shift, space1, space2)
    end
    spaces_between
  end

  def downward_diag(shift, space1, space2)
    downward_diag = []
    if space1[0] + shift == space2[0] && space1[1] + shift == space2[1]
      if shift.positive?
        (1..shift).each do |delta|
          downward_diag.push([space1[0] + delta, space1[1] + delta])
        end
      else
        (shift..-1).each do |delta|
          downward_diag.push([space1[0] + delta, space1[1] + delta])
        end
      end
    end
    downward_diag
  end

  def upward_diag(shift ,space1, space2)
    upward_diag = []
    if space1[0] - shift == space2[0] && space1[1] + shift == space2[1]
      if shift.positive?
        (1..shift).each do |delta|
          upward_diag.push([space1[0] - delta, space1[1] + delta])
        end
      else
        (shift..-1).each do |delta|
          upward_diag.push([space1[0] - delta, space1[1] + delta])
        end
      end
    end
    upward_diag
  end
end
