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

    board.game_state.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        if piece.instance_of?(Pawn)
          board_state[i][j] = 1
        elsif piece.instance_of?(Rook)
          board_state[i][j] = 2
        elsif piece.instance_of?(Knight)
          board_state[i][j] = 3
        elsif piece.instance_of?(Bishop)
          board_state[i][j] = 4
        elsif piece.instance_of?(Queen)
          board_state[i][j] = 5
        elsif piece.instance_of?(King)
          board_state[i][j] = 6
        end

        next if piece.instance_of?(Integer)

        board_state[i][j] = -board_state[i][j] if piece.color == 'b'
      end
    end

    board_state
  end
end
