# frozen_string_literal: true

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

  def self.pretty_print(board:)
    game_state = state(board: board)
    output = "  A B C D E F G H\n"

    game_state.each_with_index do |row, i|
      output += "#{i + 1} "
      row.each_with_index do |piece, j|
        case piece
        when 6
          output += "\u265a "
        when 5
          output += "\u265b "
        when 4
          output += "\u265d "
        when 3
          output += "\u265e "
        when 2
          output += "\u265c "
        when 1
          output += "\u265f "
        when 0
          if (i.even? && j.even?) || (i.odd? && j.odd?)
            output += "\u25A0 "
          else
            output += "\u25A1 "
          end
        when -1
          output += "\u2659 "
        when -2
          output += "\u2656 "
        when -3
          output += "\u2658 "
        when -4
          output += "\u2657 "
        when -5
          output += "\u2655 "
        when -6
          output += "\u2654 "
        end
      end
      output += "\n"
    end
    puts output
  end

  private
end
