# frozen_string_literal: true

require_relative 'chess'
require_relative 'modules/game_state'
require_relative 'modules/capture'

# main method
def main
  game = Chess.new(player1: 'Bob', player2: 'Linda')

  game.new_game
  game.board.move_piece(start_loc: [1, 1], end_loc: [3, 1])
  game.board.move_piece(start_loc: [1, 1], end_loc: [3, 1])

  GameState.pretty_print(board: game.board)

  p game.board.game_state[0][0].moves
end

main
