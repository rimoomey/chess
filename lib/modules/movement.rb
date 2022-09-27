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

  def piece_blocking_movement?(x:, y:, target_x:, target_y:)
    spaces_to_check = spaces_between({ x: x, y: y },
                                     { x: target_x, y: target_y })

    spaces_to_check.each do |space|
      pieces.each do |piece|
        return true if piece.current_space == space
      end
    end
    false
  end

  private

  def spaces_between(space1, space2)
    if space1[:x] == space2[:x] && space1[:y] == space2[:y]
      [space1[:x], space1[:y]]
    elsif space1[:x] == space2[:x]
      vertical_spaces_between(space1, space2)
    elsif space1[:y] == space2[:y]
      horizontal_spaces_between(space1, space2)
    else
      diagonal_spaces_between(space1, space2)
    end
  end

  def vertical_spaces_between(space1, space2)
    spaces_between = []
    ((space1[:y] + 1)...space2[:y]).each do |y_index|
      spaces_between.push([space1[:x], y_index])
    end
    spaces_between
  end

  def horizontal_spaces_between(space1, space2)
    spaces_between = []
    ((space1[:x] + 1)...space2[:x]).each do |x_index|
      spaces_between.push([x_index, space1[:y]])
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
    if space1[:x] + shift == space2[:x] && space1[:y] + shift == space2[:y]
      if shift.positive?
        (1..shift).each do |delta|
          downward_diag.push([space1[:x] + delta, space1[:y] + delta])
        end
      else
        (shift..-1).each do |delta|
          downward_diag.push([space1[:x] + delta, space1[:y] + delta])
        end
      end
    end
    downward_diag
  end

  def upward_diag(shift ,space1, space2)
    upward_diag = []
    if space1[:x] - shift == space2[:x] && space1[:y] + shift == space2[:y]
      if shift.positive?
        (1..shift).each do |delta|
          upward_diag.push([space1[:x] - delta, space1[:y] + delta])
        end
      else
        (shift..-1).each do |delta|
          upward_diag.push([space1[:x] - delta, space1[:y] + delta])
        end
      end
    end
    upward_diag
  end
end
