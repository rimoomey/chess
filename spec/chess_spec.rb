# frozen_string_literal: true

require_relative '../lib/chess'
require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/piece'
require_relative '../lib/pawn'
require_relative '../lib/rook'

describe 'Chess' do
  subject(:chess) { Chess.new(player1: player1, player2: player2, board: board) }
  let(:player1) { instance_double(Player) }
  let(:player2) { instance_double(Player) }
  let(:board) { Board.new }

  describe '#initialize' do

    it 'has a player1' do
      expect(chess.player1).to be(player1)
    end

    it 'has a player2' do
      expect(chess.player2).to be(player2)
    end

    it 'has a board' do
      expect(chess.board).to be(board)
    end
  end

  describe '#new_game' do
    context 'when a new game begins' do
      # check_pawn placement
      it 'the game board has a white pawn at [1, 2]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Pawn.new(x: 1, y: 2, color: 'w'))).to be(true)
      end
      it 'the game board has a white pawn at [2, 2]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Pawn.new(x: 2, y: 2, color: 'w'))).to be(true)
      end
      it 'the game board has a white pawn at [3, 2]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Pawn.new(x: 3, y: 2, color: 'w'))).to be(true)
      end
      it 'the game board has a white pawn at [4, 2]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Pawn.new(x: 4, y: 2, color: 'w'))).to be(true)
      end
      it 'the game board has a white pawn at [5, 2]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Pawn.new(x: 5, y: 2, color: 'w'))).to be(true)
      end
      it 'the game board has a white pawn at [6, 2]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Pawn.new(x: 6, y: 2, color: 'w'))).to be(true)
      end
      it 'the game board has a white pawn at [7, 2]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Pawn.new(x: 7, y: 2, color: 'w'))).to be(true)
      end
      it 'the game board has a white pawn at [8, 2]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Pawn.new(x: 8, y: 2, color: 'w'))).to be(true)
      end



      it 'the game board has a black pawn at [1, 7]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Pawn.new(x: 1, y: 7, color: 'b'))).to be(true)
      end
      it 'the game board has a black pawn at [2, 7]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Pawn.new(x: 2, y: 7, color: 'b'))).to be(true)
      end
      it 'the game board has a black pawn at [3, 7]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Pawn.new(x: 3, y: 7, color: 'b'))).to be(true)
      end
      it 'the game board has a black pawn at [4, 7]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Pawn.new(x: 4, y: 7, color: 'b'))).to be(true)
      end
      it 'the game board has a black pawn at [5, 7]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Pawn.new(x: 5, y: 7, color: 'b'))).to be(true)
      end
      it 'the game board has a black pawn at [6, 7]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Pawn.new(x: 6, y: 7, color: 'b'))).to be(true)
      end
      it 'the game board has a black pawn at [7, 7]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Pawn.new(x: 7, y: 7, color: 'b'))).to be(true)
      end
      it 'the game board has a black pawn at [8, 7]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Pawn.new(x: 8, y: 7, color: 'b'))).to be(true)
      end

      #check Rook placement

      it 'the game board has a white rook at [1, 1]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Rook.new(x: 1, y: 1, color: 'w'))).to be(true)
      end
      it 'the game board has a white rook at [8, 1]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Rook.new(x: 8, y: 1, color: 'w'))).to be(true)
      end
      it 'the game board has a black rook at [1, 8]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Rook.new(x: 1, y: 8, color: 'b'))).to be(true)
      end
      it 'the game board has a black rook at [8, 8]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Rook.new(x: 8, y: 8, color: 'b'))).to be(true)
      end

        #check Bishop placement

      it 'the game board has a white bishop at [3, 1]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Bishop.new(x: 3, y: 1, color: 'w'))).to be(true)
      end
      it 'the game board has a white bishop at [6, 1]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Bishop.new(x: 6, y: 1, color: 'w'))).to be(true)
      end
      it 'the game board has a black bishop at [3, 8]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Bishop.new(x: 3, y: 8, color: 'b'))).to be(true)
      end
      it 'the game board has a black bishop at [6, 8]' do
        chess.new_game
        game_board = chess.board
        expect(game_board.pieces.include?(Bishop.new(x: 6, y: 8, color: 'b'))).to be(true)
      end
    end
  end
end