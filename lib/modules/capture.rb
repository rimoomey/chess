# frozen_string_literal: true

# module for board class to control piece capturing
module Capture
  def possible_captures(piece:)
    possibles = []
    piece.capture_moves.each do |move|
      x1 = piece.current_space[0]
      y1 = piece.current_space[1]
      x2 = x1 + move[0]
      y2 = y1 + move[1]
      possibles.push([x2, y2]) if valid_capture?(piece: piece, x1: x1, y1: y1, x2: x2, y2: y2)
    end
    possibles
  end

  def piece_blocking_capture?(x:, y:, target_x:, target_y:)
    spaces_to_check = spaces_between_ex([x, y], [target_x, target_y])

    spaces_to_check.each do |space|
      return true if occupied?(x: space[0], y: space[1])
    end
    false
  end

  private

  def valid_capture?(piece:, x1:, y1:, x2:, y2:)
    return false unless in_bounds?(x: x2, y: y2)
    return false if piece_blocking_capture?(x: x1, y: y1, target_x: x2, target_y: y2)
    return false unless occupied?(x: x2, y: y2)
    return false unless diff_colors?(piece1: piece, piece2: game_state[x2][y2])

    true
  end

  def diff_colors?(piece1:, piece2:)
    piece1.color != piece2.color
  end

  def spaces_between_ex(space1, space2)
    if space1[0] == space2[0] && space1[1] == space2[1]
      [space1[0], space1[1]]
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
    ((space1[1] + 1)...space2[1]).each do |y_index|
      spaces_between.push([space1[0], y_index])
    end
    spaces_between
  end

  def vertical_spaces_between_ex(x1, x2, y)
    spaces_between = []
    ((x1 + 1)...x2).each do |x|
      spaces_between.push([x, y])
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
        (shift...-1).each do |delta|
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
        (shift...-1).each do |delta|
          upward_diag.push([space1[0] - delta, space1[1] + delta])
        end
      end
    end
    upward_diag
  end
end
