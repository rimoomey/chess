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
        board.add_piece(piece: Piece.new(x: 1, y: 1, color: 'b'))
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
    let(:piece1) { Piece.new(x: 1, y: 1, color: 'w') }
    let(:piece2) { Piece.new(x: 1, y: 2, color: 'b') }

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

    context "when a piece is in the way" do
      before do
        board.add_piece(piece: piece1)
        board.add_piece(piece: piece2)
      end
      it 'does not move the piece' do
        board.move_piece(piece: piece2, x: 1, y: 3)
        expect(board.pieces[1].current_space).to eql([1, 2])
      end
    end

    context "when there is not already a piece there" do
      before do
        board.add_piece(piece: piece1)
        board.add_piece(piece: piece2)
      end
      it 'moves the piece' do
        board.move_piece(piece: piece2, x: 2, y: 2)
        expect(board.pieces[1].current_space).to eql([2, 2])
      end
    end
  end
end

describe 'Movement' do
  subject(:board) { Board.new }

  describe '#piece_blocking_movement?' do
    context 'when piece is not in the way' do
      it 'is false' do
        expect(board.piece_blocking_movement?(x: 2,
                                              y: 3,
                                              target_x: 2,
                                              target_y: 6)).to be(false)
      end
    end

    context 'when a piece is in the way vertically' do
      before do
        board.add_piece(piece: Piece.new(x: 2, y: 4, color: 'w') )
      end
      it 'is true' do
        expect(board.piece_blocking_movement?(x: 2,
                                              y: 3,
                                              target_x: 2,
                                              target_y: 6)).to be(true)
      end
    end

    context 'when a piece is in the way horizontally' do
      before do
        board.add_piece(piece: Piece.new(x: 6, y: 3, color: 'w') )
      end
      it 'is true' do
        expect(board.piece_blocking_movement?(x: 2,
                                              y: 3,
                                              target_x: 8,
                                              target_y: 3)).to be(true)
      end
    end

    context 'when a piece is in the way diagonally' do
      before do
        board.add_piece(piece: Piece.new(x: 5, y: 6, color: 'w') )
      end
      it 'is true' do
        expect(board.piece_blocking_movement?(x: 2,
                                              y: 3,
                                              target_x: 6,
                                              target_y: 7)).to be(true)
      end
    end

    context 'when a piece is in the way differently diagonally' do
      before do
        board.add_piece(piece: Piece.new(x: 5, y: 6, color: 'w') )
      end
      it 'is true' do
        expect(board.piece_blocking_movement?(x: 4,
                                              y: 5,
                                              target_x: 6,
                                              target_y: 7)).to be(true)
      end
    end

    context 'when a piece is in the way diagonally a 3rd way' do
      before do
        board.add_piece(piece: Piece.new(x: 5, y: 6, color: 'w') )
      end
      it 'is true' do
        expect(board.piece_blocking_movement?(x: 6,
                                              y: 7,
                                              target_x: 3,
                                              target_y: 4)).to be(true)
      end
    end

    context 'when a piece is in the way diagonally a 4th way' do
      before do
        board.add_piece(piece: Piece.new(x: 5, y: 6, color: 'w') )
      end
      it 'is true' do
        expect(board.piece_blocking_movement?(x: 4,
                                              y: 7,
                                              target_x: 6,
                                              target_y: 5)).to be(true)
      end
    end
  end
end
