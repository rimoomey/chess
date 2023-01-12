# frozen_string_literal: true

# module for board class to control piece capturing
module Capture
  def possible_captures(piece:, place:)
    possibles = []
    piece.capture_moves.each do |move|
      x1 = place[0]
      y1 = place[1]
      x2 = x1 + move[0]
      y2 = y1 + move[1]

      possibles.push([x2, y2]) if valid_capture?(piece: piece, start_loc: [x1, y1], end_loc: [x2, y2])
    end
    possibles
  end

  def piece_blocking_capture?(start_loc:, end_loc:)
    spaces_to_check = spaces_between_ex(start_loc, end_loc)

    spaces_to_check.each do |space|
      return true if occupied?(point: space)
    end
    false
  end

  private

  def valid_capture?(piece:, start_loc:, end_loc:)
    return false unless in_bounds?(point: end_loc)
    return false unless occupied?(point: end_loc)
    return false unless diff_colors?(piece1: piece, piece2: game_state[end_loc[0]][end_loc[1]])
    return true if piece.instance_of?(Knight)
    return false if piece_blocking_capture?(start_loc: start_loc, end_loc: end_loc)

    true
  end

  def diff_colors?(piece1:, piece2:)
    piece1.color != piece2.color
  end

  def spaces_between_ex(space1, space2)
    if space1[0] == space2[0] && space1[1] == space2[1]
      []
    elsif space1[0] == space2[0]
      horizontal_spaces_between_ex(space1, space2)
    elsif space1[1] == space2[1]
      y = space1[1]
      vertical_spaces_between_ex(space1[0], space2[0], y)
    else
      diagonal_spaces_between_ex(space1, space2)
    end
  end

  def horizontal_spaces_between_ex(space1, space2)
    spaces_between = []
    if space1[1] < space2[1]
      ((space1[1] + 1)...space2[1]).each do |y_index|
        spaces_between.push([space1[0], y_index])
      end
    else
      ((space2[1] + 1)...space1[1]).each do |y_index|
        spaces_between.push([space1[0], y_index])
      end
    end
    spaces_between
  end

  def vertical_spaces_between_ex(x1, x2, y)
    spaces_between = []
    if x1 < x2
      ((x1 + 1)...x2).each do |x|
        spaces_between.push([x, y])
      end
    else
      ((x2 + 1)...x1).each do |x|
        spaces_between.push([x, y])
      end
    end
    spaces_between
  end

  def diagonal_spaces_between_ex(space1, space2)
    spaces_between = []
    (-8..8).each do |shift|
      spaces_between += downward_diag_ex(shift, space1, space2)
      spaces_between += upward_diag_ex(shift, space1, space2)
    end
    spaces_between
  end

  def downward_diag_ex(shift, space1, space2)
    downward_diag = []
    if space1[0] + shift == space2[0] && space1[1] + shift == space2[1]
      if shift.positive?
        (1...shift).each do |delta|
          downward_diag.push([space1[0] + delta, space1[1] + delta])
        end
      else
        ((shift + 1)..-1).each do |delta|
          downward_diag.push([space1[0] + delta, space1[1] + delta])
        end
      end
    end
    downward_diag
  end

  def upward_diag_ex(shift ,space1, space2)
    upward_diag = []
    if space1[0] - shift == space2[0] && space1[1] + shift == space2[1]
      if shift.positive?
        (1...shift).each do |delta|
          upward_diag.push([space1[0] - delta, space1[1] + delta])
        end
      else
        ((shift + 1)..-1).each do |delta|
          upward_diag.push([space1[0] - delta, space1[1] + delta])
        end
      end
    end
    upward_diag
  end
end
