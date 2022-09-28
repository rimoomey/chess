# frozen_string_literal: true

require_relative '../lib/chess'
require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/pawn'
require_relative '../lib/rook'

describe 'Chess' do
  subject(:chess) { Chess.new(player1: player1, player2: player2) }
  let(:player1) { instance_double(Player) }
  let(:player2) { instance_double(Player) }

  describe '#initialize' do

    it 'has a player1' do
      expect(chess.player1).to be(player1)
    end

    it 'has a player2' do
      expect(chess.player2).to be(player2)
    end
  end

  describe '#new_game' do
    context 'when a new game begins' do
      # check_pawn placement
      it 'the game board has a white pawn at [1, 0]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[1][0]).to eq(Pawn.new(x: 1, y: 0, color: 'w'))
      end
      it 'the game board has a white pawn at [1, 1]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[1][1]).to eq(Pawn.new(x: 1, y: 1, color: 'w'))
      end
      it 'the game board has a white pawn at [1, 2]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[1][2]).to eq(Pawn.new(x: 1, y: 2, color: 'w'))
      end
      it 'the game board has a white pawn at [1, 3]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[1][3]).to eq(Pawn.new(x: 1, y: 3, color: 'w'))
      end
      it 'the game board has a white pawn at [1, 4]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[1][4]).to eq(Pawn.new(x: 1, y: 4, color: 'w'))
      end
      it 'the game board has a white pawn at [1, 5]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[1][5]).to eq(Pawn.new(x: 1, y: 5, color: 'w'))
      end
      it 'the game board has a white pawn at [1, 6]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[1][6]).to eq(Pawn.new(x: 1, y: 6, color: 'w'))
      end
      it 'the game board has a white pawn at [1, 7]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[1][7]).to eq(Pawn.new(x: 1, y: 7, color: 'w'))
      end
      it 'the game board has a black pawn at [8, 0]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[6][0]).to eq(Pawn.new(x: 6, y: 0, color: 'b'))
      end
      it 'the game board has a black pawn at [6, 1]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[6][1]).to eq(Pawn.new(x: 6, y: 1, color: 'b'))
      end
      it 'the game board has a black pawn at [6, 2]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[6][2]).to eq(Pawn.new(x: 6, y: 2, color: 'b'))
      end
      it 'the game board has a black pawn at [6, 3]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[6][3]).to eq(Pawn.new(x: 6, y: 3, color: 'b'))
      end
      it 'the game board has a black pawn at [6, 4]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[6][4]).to eq(Pawn.new(x: 6, y: 4, color: 'b'))
      end
      it 'the game board has a black pawn at [6, 5]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[6][5]).to eq(Pawn.new(x: 6, y: 5, color: 'b'))
      end
      it 'the game board has a black pawn at [6, 6]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[6][6]).to eq(Pawn.new(x: 6, y: 6, color: 'b'))
      end
      it 'the game board has a black pawn at [6, 7]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[6][7]).to eq(Pawn.new(x: 6, y: 7, color: 'b'))
      end

      #check Rook placement

      it 'the game board has a white rook at [0, 0]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[0][0]).to eq(Rook.new(x: 0, y: 0, color: 'w'))
      end
      it 'the game board has a white rook at [0, 7]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[0][7]).to eq(Rook.new(x: 0, y: 7, color: 'w'))
      end
      it 'the game board has a black rook at [7, 0]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[7][0]).to eq(Rook.new(x: 7, y: 0, color: 'b'))
      end
      it 'the game board has a black rook at [7, 7]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[7][7]).to eq(Rook.new(x: 7, y: 7, color: 'b'))
      end

        #check Bishop placement

      it 'the game board has a white bishop at [0, 2]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[0][2]).to eq(Bishop.new(x: 0, y: 2, color: 'w'))
      end
      it 'the game board has a white bishop at [0, 5]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[0][5]).to eq(Bishop.new(x: 0, y: 5, color: 'w'))
      end
      it 'the game board has a black bishop at [7, 2]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[7][2]).to eq(Bishop.new(x: 7, y: 2, color: 'b'))
      end
      it 'the game board has a black bishop at [7, 5]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.game_state[7][5]).to eq(Bishop.new(x: 7, y: 5, color: 'b'))
      end
    end
  end
end