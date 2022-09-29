# frozen_string_literal: true

require_relative 'chess'
require_relative 'modules/game_state'

# main method
def main
  game = Chess.new(player1: 'Bob', player2: 'Linda')
  state1 = GameState.state(board: game.board)
  state1.each { |row| p row }

  puts

  game.new_game
  game.board.move_piece(start_loc: [1, 1], end_loc: [3, 1])
  game.board.move_piece(start_loc: [1, 1], end_loc: [3, 1])
  state2 = GameState.state(board: game.board)
  state2.each { |row| p row }
end

main
