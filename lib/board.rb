# frozen_string_literal: true

# class to represent a chess board
class Board
  attr_reader :pieces, :dimensions

  def initialize(x: 8, y: 8)
    @pieces = []
    @dimensions = [x, y]
  end
end
