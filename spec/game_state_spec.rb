# frozen_string_literal: true

require_relative '../lib/modules/game_state'

describe 'GameState' do
  subject(:game) { Chess.new(player1: 'player', player2: 'other_player', board: game_board)}
  let(:game_board) { Board.new }

  describe '#state' do
    context 'when the game board is empty' do
      xit 'returns [[0,..., 0],...,[0,..., 0]]' do
        expect(GameState::state(board: game_board)).to eql([[0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0]])
      end
    end

    context 'when the game board has a pawn at d6' do
      before do
        game_board.add_piece(piece: Pawn.new(x: 3, y: 4, color: 'w'))
      end

      xit 'returns a 1 in the proper place' do
        expect(GameState::state(board: game_board)).to eql([[0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 1, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0]])
      end
    end

    context 'when the game board has a pawn at d6 and a king at e8' do
      before do
        game_board.add_piece(piece: Pawn.new(x: 3, y: 4, color: 'w'))
        game_board.add_piece(piece: King.new(x: 1, y: 5, color: 'w'))
      end

      xit 'returns a 1 and a 6 in the proper places' do
        expect(GameState::state(board: game_board)).to eql([[0, 0, 0, 0, 6, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 1, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0]])
      end
    end

    context 'when the game has begun' do
      before do
        game.new_game
      end

      xit 'returns all proper places' do
        expect(GameState::state(board: game_board)).to eql([[2, 0, 4, 0, 0, 4, 0, 2],
                                                            [1, 1, 1, 1, 1, 1, 1, 1],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [-1, -1, -1, -1, -1, -1, -1, -1],
                                                            [-2, 0, -4, 0, 0, -4, 0, -2]])
      end
    end
  end
end