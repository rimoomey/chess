# frozen_string_literal: true

require_relative '../lib/board'

describe 'Board' do
  subject(:board) { Board.new }
  describe '#initialize' do
    context 'when a new board is created' do
      it 'has no pieces' do
        expect(board.pieces).to eql([])
      end
    end
  end

  describe '#in_bounds?' do
    context 'when an index is within board dimensions' do
      it 'is true' do
        expect(board.in_bounds?(x: 1, y: 2)).to be(true)
      end
    end

    context 'when x is out of bounds' do
      it 'is false' do
        expect(board.in_bounds?(x: 9, y: 2)).to be(false)
      end
    end

    context 'when y is out of bounds' do
      it 'is false' do
        expect(board.in_bounds?(x: 3, y: -9)).to be(false)
      end
    end

    context 'when x and y are out of bounds' do
      it 'is false' do
        expect(board.in_bounds?(x: -2,y: 9)).to be(false)
      end
    end
  end

  describe '#occupied?' do
    context 'when a piece occupies a given space' do
      before do
        board.add_piece(piece: Piece.new(x: 1, y: 1, board: board, color: 'b'))
      end

      it 'returns true' do
        expect(board.occupied?(x: 1, y: 1)).to be(true)
      end
    end

    context 'when a piece does not occupy a given space' do
      it 'returns false' do
        expect(board.occupied?(x: 5, y: 4)).to be(false)
      end
    end
  end

  describe '#move_piece' do
    let(:piece1) { Piece.new(x: 1, y: 1, board: board, color: 'w') }
    let(:piece2) { Piece.new(x: 1, y: 2, board: board, color: 'b') }

    context "when there's already a piece there" do
      before do
        board.add_piece(piece: piece1)
        board.add_piece(piece: piece2)
      end
      it 'does not move the piece' do
        board.move_piece(piece: piece2, x: 1, y: 1)
        expect(board.pieces[1].current_space).to eql([1, 2])
      end
    end

    context "when there is not already a piece there" do
      before do
        board.add_piece(piece: piece1)
        board.add_piece(piece: piece2)
      end
      it 'moves the piece' do
        board.move_piece(piece: piece2, x: 1, y: 3)
        expect(board.pieces[1].current_space).to eql([1, 3])
      end
    end
  end
end
