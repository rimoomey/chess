# frozen_string_literal: true

require_relative '../lib/modules/game_state'

describe 'GameState' do
  subject(:game) { Chess.new(player1: 'player', player2: 'other_player')}
  let(:game_board) { Board.new }

  describe '#state' do
    context 'when the game board is empty' do
      it 'returns [[0,..., 0],...,[0,..., 0]]' do
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
        game_board.add_piece(piece: Pawn.new(color: 'w'), location: [2, 3])
      end

      it 'returns a 1 in the proper place' do
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
        game_board.add_piece(piece: Pawn.new(color: 'w'), location: [2, 3])
        game_board.add_piece(piece: King.new(color: 'w'), location: [0, 4])
      end

      it 'returns a 1 and a 6 in the proper places' do
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

      it 'returns all proper places' do
        expect(GameState::state(board: game.board)).to eql([[2, 3, 4, 6, 5, 4, 3, 2],
                                                            [1, 1, 1, 1, 1, 1, 1, 1],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [0, 0, 0, 0, 0, 0, 0, 0],
                                                            [-1, -1, -1, -1, -1, -1, -1, -1],
                                                            [-2, -3, -4, -6, -5, -4, -3, -2]])
      end
    end
  end
end