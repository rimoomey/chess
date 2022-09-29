# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/piece'
require_relative '../lib/rook'
require_relative '../lib/knight'
require_relative '../lib/bishop'
require_relative '../lib/pawn'
require_relative '../lib/queen'
require_relative '../lib/king'

describe 'Capture' do
  subject(:board) { Board.new }

  describe '#piece_blocking_capture?' do
    context 'when there is no piece in the way' do
      it 'is false' do
        expect(board.piece_blocking_capture?(x: 1, y: 1, target_x: 3, target_y: 3)).to be(false)
      end
    end

    context 'when there is a piece in the way horizontally' do
      before do
        board.add_piece(piece: Piece.new(x: 1, y: 2, color: 'black'), location: [1, 2])
      end
      it 'is true' do
        expect(board.piece_blocking_capture?(x: 1, y: 1, target_x: 1, target_y: 3)).to be(true)
      end
    end

    context 'when there is a piece in the way vertically' do
      before do
        board.add_piece(piece: Piece.new(x: 2, y: 1, color: 'black'), location: [2, 1])
      end
      it 'is true' do
        expect(board.piece_blocking_capture?(x: 1, y: 1, target_x: 3, target_y: 1)).to be(true)
      end
    end

    context 'when there is a piece in the way diagonally' do
      before do
        board.add_piece(piece: Piece.new(x: 2, y: 2, color: 'black'), location: [2, 2])
      end
      it 'is true' do
        expect(board.piece_blocking_capture?(x: 1, y: 1, target_x: 3, target_y: 3)).to be(true)
      end
    end

    context 'when there is a piece on the spot to capture' do
      before do
        board.add_piece(piece: Piece.new(x: 3, y: 3, color: 'black'), location: [3, 3])
      end
      it 'is false' do
        expect(board.piece_blocking_capture?(x: 1, y: 1, target_x: 3, target_y: 3)).to be(false)
      end
    end
  end
end