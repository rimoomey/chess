# frozen_string_literal: true

# class to represent a chess board
class Board
  attr_reader :pieces

  DIMENSIONS = [8, 8].freeze

  def initialize
    @pieces = []
  end

  def piece_blocking_movement?(current_x:, current_y:, target_x:, target_y:)
    spaces_to_check = spaces_between({ x: current_x, y: current_y },
                                     { x: target_x, y: target_y })

    spaces_to_check.each do |space|
      pieces.each do |piece|
        return true if piece.current_space == space
      end
    end
    false
  end

  def in_bounds?(x:, y:)
    x.positive? && x <= DIMENSIONS[0] && y.positive? &&
      y <= DIMENSIONS[1]
  end

  def occupied?(x:, y:)
    pieces.each do |piece|
      return true if piece.current_space == [x, y]
    end
    false
  end

  def add_piece(piece:)
    @pieces.push(piece)
  end

  def move_piece(piece:, x:, y:)
    piece.move(x: x, y: y) unless occupied?(x: x, y: y) || !in_bounds?(x: x, y: y)
  end

  private

  def spaces_between(space1, space2)
    spaces_between = []

    if space1[:x] == space2[:x] && space1[:y] == space2[:y]
      spaces_between.push([space1[:x], space1[:y]])
    elsif space1[:x] == space2[:x]
      ((space1[:y] + 1)...space2[:y]).each do |y_index|
        spaces_between.push([space1[:x], y_index])
      end
    elsif space1[:y] == space2[:y]
      ((space1[:x] + 1)...space2[:x]).each do |x_index|
        spaces_between.push([x_index, space1[:y]])
      end
    else
      8.times do |shift|
        next unless space1[:x] + shift == space2[:x] && space1[:y] + shift == space2[:y]

        (1...shift).each do |delta|
          spaces_between.push([space1[:x] + delta, space1[:y] + delta])
        end
      end
    end

    spaces_between
  end
end
