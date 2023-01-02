# frozen_string_literal: true

describe 'Capture' do
  subject(:board) { Board.new }
  let(:queen) { Queen.new(color: 'b') }
  let(:pawn) { Pawn.new(color: 'b') }
  let(:w_queen) { Queen.new(color: 'w') }

  describe '#piece_blocking_capture?' do
    context 'when there is no piece in the way' do
      it 'is false' do
        expect(board.piece_blocking_capture?(start_loc: [1, 1], end_loc: [3, 3])).to be(false)
      end
    end

    context 'when there is a piece in the way horizontally' do
      before do
        board.add_piece(piece: Piece.new(color: 'black'), location: [1, 2])
      end
      it 'is true' do
        expect(board.piece_blocking_capture?(start_loc: [1, 1], end_loc: [1, 3])).to be(true)
      end
    end

    context 'when there is a piece in the way vertically' do
      before do
        board.add_piece(piece: Piece.new(color: 'black'), location: [2, 1])
      end
      it 'is true' do
        expect(board.piece_blocking_capture?(start_loc: [1, 1], end_loc: [3, 1])).to be(true)
      end
    end

    context 'when there is a piece in the way diagonally' do
      before do
        board.add_piece(piece: Piece.new(color: 'black'), location: [2, 2])
      end
      it 'is true' do
        expect(board.piece_blocking_capture?(start_loc: [1, 1], end_loc: [3, 3])).to be(true)
      end
    end

    context 'when there is a piece on the spot to capture' do
      before do
        board.add_piece(piece: Piece.new(color: 'black'), location: [3, 3])
      end
      it 'is false' do
        expect(board.piece_blocking_capture?(start_loc: [1, 1], end_loc: [3, 3])).to be(false)
      end
    end
  end

  describe '#possible_captures' do
    context 'when the capturing piece is not a pawn and there are 3 pieces for capture' do
      before do
        board.add_piece( piece: Piece.new(color: 'w'), location: [3, 3] )
        board.add_piece( piece: Piece.new(color: 'w'), location: [2, 3] )
        board.add_piece( piece: Piece.new(color: 'w'), location: [3, 1] )
      end

      it 'returns [3, 3], [2, 3], [3, 1]' do
        expect(board.possible_captures(piece: queen, place: [2, 2])).to eq([[2, 3], [3, 3], [3, 1]])
      end
    end

    context 'when the capturing piece is not a pawn, 3 pieces for capture, one blocked' do
      before do
        board.add_piece( piece: Piece.new(color: 'w'), location: [4, 4] )
        board.add_piece( piece: Piece.new(color: 'w'), location: [3, 3] )
        board.add_piece( piece: Piece.new(color: 'w'), location: [2, 3] )
        board.add_piece( piece: Piece.new(color: 'w'), location: [3, 1] )
      end

      it 'returns [3, 3], [2, 3], [3, 1]' do
        expect(board.possible_captures(piece: queen, place: [2, 2])).to eq([[2, 3], [3, 3], [3, 1]])
      end
    end

    context 'when the capturing piece is a pawn, and the target is right in front' do
      before do
        board.add_piece( piece: Piece.new(color: 'w'), location: [2, 1] )
      end

      it 'returns []' do
        expect(board.possible_captures(piece: pawn, place: [1, 1])).to eq([])
      end
    end

    context 'when the capturing piece is white and the target is white' do
      before do
        board.add_piece( piece: Piece.new(color: 'w'), location: [4, 5] )
      end

      it 'returns []' do
        expect(board.possible_captures(piece: w_queen, place: [3, 5])).to eq([])
      end
    end

    context 'when the capturing piece is a queen, but a piece is in the way of a target' do
      before do
        board.add_piece( piece: Piece.new(color: 'b'), location: [4, 1])
        board.add_piece( piece: Piece.new(color: 'b'), location: [4, 2])
      end

      it 'returns [4, 2]' do
        expect(board.possible_captures(piece: w_queen, place: [4, 4])).to eq([[4, 2]])
      end
    end
  end
end