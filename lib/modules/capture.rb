# frozen_string_literal: true

# module for board class to control piece capturing
module Capture
  def piece_blocking_capture?(x:, y:, target_x:, target_y:)
    spaces_to_check = spaces_between_ex([x, y], [target_x, target_y])

    spaces_to_check.each do |space|
      return true if occupied?(x: space[0], y: space[1])
    end
    false
  end

  private

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
