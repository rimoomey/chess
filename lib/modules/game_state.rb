# frozen_string_literal: true

require_relative '../pawn'
require_relative '../king'

# module to collect state of board
module GameState
  def self.state(board:)
    board_state = [[0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0]]
    i = nil

    board.pieces.each do |piece|
      if piece.instance_of?(Pawn)
        i = 1
      elsif piece.instance_of?(Rook)
        i = 2
      elsif piece.instance_of?(Knight)
        i = 3
      elsif piece.instance_of?(Bishop)
        i = 4
      elsif piece.instance_of?(Queen)
        i = 5
      elsif piece.instance_of?(King)
        i = 6
      end

      i = -i if piece.color.downcase == 'b'

      board_state[piece.current_space[0] - 1][piece.current_space[1] - 1] = i
      i = 0
    end
    board_state
  end
end
