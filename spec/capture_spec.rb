# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/piece'
require_relative '../lib/pawn'
require_relative '../lib/queen'

describe 'Capture' do
  subject(:board) { Board.new }
  let(:queen) { Queen.new(x: 2, y: 2, color: 'b') }
  let(:pawn) { Pawn.new(x: 1, y: 1, color: 'b') }
  let(:w_queen) { Queen.new(x: 4, y: 4, color: 'w') }

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

  describe '#possible_captures' do
    context 'when the capturing piece is not a pawn and there are 3 pieces for capture' do
      before do
        board.add_piece( piece: Piece.new(x: 3, y: 3, color: 'w'), location: [3, 3] )
        board.add_piece( piece: Piece.new(x: 2, y: 3, color: 'w'), location: [2, 3] )
        board.add_piece( piece: Piece.new(x: 3, y: 1, color: 'w'), location: [3, 1] )
      end

      it 'returns [3, 3], [2, 3], [3, 1]' do
        expect(board.possible_captures(piece: queen)).to eq([[2, 3], [3, 3], [3, 1]])
      end
    end

    context 'when the capturing piece is not a pawn, 3 pieces for capture, one blocked' do
      before do
        board.add_piece( piece: Piece.new(x: 4, y: 4, color: 'w'), location: [4, 4] )
        board.add_piece( piece: Piece.new(x: 3, y: 3, color: 'w'), location: [3, 3] )
        board.add_piece( piece: Piece.new(x: 2, y: 3, color: 'w'), location: [2, 3] )
        board.add_piece( piece: Piece.new(x: 3, y: 1, color: 'w'), location: [3, 1] )
      end

      it 'returns [3, 3], [2, 3], [3, 1]' do
        expect(board.possible_captures(piece: queen)).to eq([[2, 3], [3, 3], [3, 1]])
      end
    end

    context 'when the capturing piece is a pawn, and the target is right in front' do
      before do
        board.add_piece( piece: Piece.new(x: 2, y: 1, color: 'w'), location: [2, 1] )
      end

      it 'returns []' do
        expect(board.possible_captures(piece: pawn)).to eq([])
      end
    end

    context 'when the capturing piece is a pawn, and the target is right in front' do
      before do
        board.add_piece( piece: Piece.new(x: 2, y: 1, color: 'w'), location: [2, 1] )
      end

      it 'returns []' do
        expect(board.possible_captures(piece: pawn)).to eq([])
      end
    end

    context 'when the capturing piece is white and the target is white' do
      before do
        board.add_piece( piece: Piece.new(x: 4, y: 5, color: 'w'), location: [4, 5] )
      end

      it 'returns []' do
        expect(board.possible_captures(piece: w_queen)).to eq([])
      end
    end
  end
end