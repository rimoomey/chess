# frozen_string_literal: true

# class to represent a chess board

class Board
  attr_reader :pieces
  def initialize
    @pieces = []
  end
end