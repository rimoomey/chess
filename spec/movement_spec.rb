# frozen_string_literal: true

describe 'Movement' do
  subject(:board) { Board.new }
  let(:generic_piece) { Piece.new(color: 'w') }
  let(:pawn) { Pawn.new(color: 'w') }
  let(:rook) { Rook.new(color: 'w') }
  let(:knight) { Knight.new(color: 'w') }
  let(:bishop) { Bishop.new(color: 'w') }
  let(:queen) { Queen.new(color: 'w') }
  let(:king) { King.new(color: 'w') }

  describe '#possible_moves' do

    context 'when the supplied piece is generic' do
      it 'returns no possible moves' do
        expect(board.possible_moves(piece: generic_piece, place: [1, 1])).to eql([])
      end
    end

    context 'when the supplied piece is a white pawn' do
      it 'returns four possible moves' do
        expect(board.possible_moves(piece: pawn, place: [0, 1])).to eql([[1, 1], [2, 1]])
      end
    end

    context 'when the supplied piece is a rook' do
      it 'returns the entire row and entire column' do
        expect(board.possible_moves(piece: rook, place: [1, 1])).to eql([[1, 2], [1, 3], [1, 4], [1, 5],
                                                           [1, 6], [1, 7], [1, 0], [2, 1],
                                                           [3, 1], [4, 1], [5, 1], [6, 1],
                                                           [7, 1], [0, 1]])
      end
    end

    context 'when the supplied piece is a knight' do
      it 'has the correct possible moves' do
        expect(board.possible_moves(piece: knight, place: [2, 1])).to eql([[3, 3], [4, 2], [4, 0],
                                                            [1, 3], [0, 2], [0, 0]])
      end
    end

    context 'when the supplied piece is a bishop at [2, 1]' do
      it 'has the diagonals' do
        expected_moves = [[3, 2], [4, 3], [5, 4], [6, 5], [7, 6], [1, 2], [0, 3], [3, 0], [1, 0]]
        expect(board.possible_moves(piece: bishop, place: [2, 1])).to eql(expected_moves)
      end
    end

    context 'when the supplied piece is a Queen at [4, 4]' do
      it 'has the correct possible moves' do
        expect(board.possible_moves(piece: queen, place: [4, 4])).to eql([[4, 5], [4, 6], [4, 7], [4, 3], [4, 2], [4, 1], [4, 0],
                                                           [5, 4], [6, 4], [7, 4], [3, 4], [2, 4], [1, 4], [0, 4],
                                                           [5, 5], [6, 6], [7, 7], [5, 3], [6, 2], [7, 1], [3, 5],
                                                           [2, 6], [1, 7], [3, 3], [2, 2], [1, 1], [0, 0]])
      end
    end

    context 'when the supplied piece is a King at [4, 4]' do
      it 'has the correct possible moves' do
        expect(board.possible_moves(piece: king, place: [4, 4])).to eql([[4, 5], [4, 3], [5, 4], [3, 4],
                                            [5, 5], [5, 3], [3, 5], [3, 3]])
      end
    end

    context 'when the supplied piece is a Pawn at [1,1] and theres another piece at [2,1]' do
      before do
        board.add_piece(piece: Pawn.new(color: 'b'), location: [2, 1])
      end
      it 'has no possible moves' do
        expect(board.possible_moves(piece: pawn, place: [1, 1])).to eql([])
      end
    end
  end

  describe '#piece_blocking_movement?' do
    context 'when there is no piece in the way' do
      it 'is false' do
        expect(board.piece_blocking_movement?(start_loc: [1, 1], end_loc: [3, 3])).to be(false)
      end
    end
  end

  describe '#piece_blocking_movement?' do
    context 'when there is a piece in the way vertically' do
      before do
        board.add_piece(piece: bishop, location: [2, 1])
      end
      it 'is true' do
        expect(board.piece_blocking_movement?(start_loc: [1, 1], end_loc: [3, 1])).to be(true)
      end
    end
  end

  describe '#piece_blocking_movement?' do
    context 'when there is a piece in the way horizontally' do
      before do
        board.add_piece(piece: Rook.new(color: 'b'), location: [1, 2])
      end
      it 'is true' do
        expect(board.piece_blocking_movement?(start_loc: [1, 1], end_loc: [1, 3])).to be(true)
      end
    end
  end

  describe '#piece_blocking_movement?' do
    context 'when there is a piece in the way diagonally' do
      before do
        board.add_piece(piece: Rook.new(color: 'b'), location: [2, 2])
      end
      it 'is true' do
        expect(board.piece_blocking_movement?(start_loc: [3, 3], end_loc: [1, 1])).to be(true)
      end
    end
  end
end
