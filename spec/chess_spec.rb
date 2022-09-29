# frozen_string_literal: true

require_relative '../lib/chess'
require_relative '../lib/board'
require_relative '../lib/pawn'
require_relative '../lib/rook'
require_relative '../lib/knight'
require_relative '../lib/bishop'
require_relative '../lib/queen'
require_relative '../lib/king'

describe 'Chess' do
  subject(:chess) { Chess.new(player1: 'bob', player2: 'linda') }

  describe '#initialize' do

    it 'has a player1' do
      expect(chess.player1).to eq('bob')
    end

    it 'has a player2' do
      expect(chess.player2).to eq('linda')
    end
  end

  describe '#new_game' do
    context 'when a new game begins' do
      # check_pawn placement
      it 'the game board has a white pawn at [1, 0]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[1][0]).to eq(Pawn.new(color: 'w'))
      end
      it 'the game board has a white pawn at [1, 1]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[1][1]).to eq(Pawn.new(color: 'w'))
      end
      it 'the game board has a white pawn at [1, 2]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[1][2]).to eq(Pawn.new(color: 'w'))
      end
      it 'the game board has a white pawn at [1, 3]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[1][3]).to eq(Pawn.new(color: 'w'))
      end
      it 'the game board has a white pawn at [1, 4]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[1][4]).to eq(Pawn.new(color: 'w'))
      end
      it 'the game board has a white pawn at [1, 5]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[1][5]).to eq(Pawn.new(color: 'w'))
      end
      it 'the game board has a white pawn at [1, 6]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[1][6]).to eq(Pawn.new(color: 'w'))
      end
      it 'the game board has a white pawn at [1, 7]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[1][7]).to eq(Pawn.new(color: 'w'))
      end
      it 'the game board has a black pawn at [8, 0]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[6][0]).to eq(Pawn.new(color: 'b'))
      end
      it 'the game board has a black pawn at [6, 1]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[6][1]).to eq(Pawn.new(color: 'b'))
      end
      it 'the game board has a black pawn at [6, 2]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[6][2]).to eq(Pawn.new(color: 'b'))
      end
      it 'the game board has a black pawn at [6, 3]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[6][3]).to eq(Pawn.new(color: 'b'))
      end
      it 'the game board has a black pawn at [6, 4]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[6][4]).to eq(Pawn.new(color: 'b'))
      end
      it 'the game board has a black pawn at [6, 5]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[6][5]).to eq(Pawn.new(color: 'b'))
      end
      it 'the game board has a black pawn at [6, 6]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[6][6]).to eq(Pawn.new(color: 'b'))
      end
      it 'the game board has a black pawn at [6, 7]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[6][7]).to eq(Pawn.new(color: 'b'))
      end

      #check Rook placement

      it 'the game board has a white rook at [0, 0]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[0][0]).to eq(Rook.new(color: 'w'))
      end
      it 'the game board has a white rook at [0, 7]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[0][7]).to eq(Rook.new(color: 'w'))
      end
      it 'the game board has a black rook at [7, 0]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[7][0]).to eq(Rook.new(color: 'b'))
      end
      it 'the game board has a black rook at [7, 7]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[7][7]).to eq(Rook.new(color: 'b'))
      end

        #check Bishop placement

      it 'the game board has a white bishop at [0, 2]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[0][2]).to eq(Bishop.new(color: 'w'))
      end
      it 'the game board has a white bishop at [0, 5]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[0][5]).to eq(Bishop.new(color: 'w'))
      end
      it 'the game board has a black bishop at [7, 2]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[7][2]).to eq(Bishop.new(color: 'b'))
      end
      it 'the game board has a black bishop at [7, 5]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[7][5]).to eq(Bishop.new(color: 'b'))
      end

      #check Knight placement

      it 'the game board has a white knight at [0, 1]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[0][1]).to eq(Knight.new(color: 'w'))
      end
      it 'the game board has a white knight at [0, 6]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[0][6]).to eq(Knight.new(color: 'w'))
      end
      it 'the game board has a black knight at [7, 1]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[7][1]).to eq(Knight.new(color: 'b'))
      end
      it 'the game board has a black knight at [7, 6]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[7][6]).to eq(Knight.new(color: 'b'))
      end

      # check Queen placement

      it 'the game board has a white queen at [0, 4]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[0][4]).to eq(Queen.new(color: 'w'))
      end

      it 'the game board has a black queen at [0, 4]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[7][4]).to eq(Queen.new(color: 'b'))
      end
    end

    # check King placement

    it 'the game board has a white king at [0, 3]' do
      chess.new_game
      game_board = chess.board
      expect(game_board.game_state[0][3]).to eq(King.new(color: 'w'))
    end

    it 'the game board has a black king at [7, 3]' do
      chess.new_game
      game_board = chess.board
      expect(game_board.game_state[7][3]).to eq(King.new(color: 'b'))
    end
  end
end