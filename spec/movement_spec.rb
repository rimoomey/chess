# frozen_string_literal: true

require_relative '../lib/modules/movement'
require_relative '../lib/board'
require_relative '../lib/piece'
require_relative '../lib/pawn'
require_relative '../lib/rook'
require_relative '../lib/knight'
require_relative '../lib/bishop'
require_relative '../lib/queen'
require_relative '../lib/king'

describe 'Movement' do
  subject(:board) { Board.new }
  let(:generic_piece) { Piece.new(x: 1, y: 1, color: 'w') }
  let(:pawn) { Pawn.new(x: 1, y: 1, color: 'w') }
  let(:rook) { Rook.new(x: 1, y: 1, color: 'w') }
  let(:knight) { Knight.new(x: 2, y: 1, color: 'w') }
  let(:bishop) { Bishop.new(x: 2, y: 1, color: 'w') }
  let(:queen) { Queen.new(x: 4, y: 4, color: 'w') }
  let(:king) { King.new(x: 4, y: 4, color: 'w') }

  describe '#possible_moves' do

    context 'when the supplied piece is generic' do
      it 'returns no possible moves' do
        expect(board.possible_moves(piece: generic_piece)).to eql([])
      end
    end

    context 'when the supplied piece is a pawn' do
      it 'returns three possible moves' do
        expect(board.possible_moves(piece: pawn)).to eql([[1, 2], [1, 3], [0, 2], [2, 2]])
      end
    end

    context 'when the supplied piece is a rook' do
      it 'returns the entire row and entire column' do
        expect(board.possible_moves(piece: rook)).to eql([[1, 2], [1, 3], [1, 4], [1, 5],
                                                           [1, 6], [1, 7], [1, 0], [2, 1],
                                                           [3, 1], [4, 1], [5, 1], [6, 1],
                                                           [7, 1], [0, 1]])
      end
    end

    context 'when the supplied piece is a knight' do
      it 'has the correct possible moves' do
        expect(board.possible_moves(piece: knight)).to eql([[3, 3], [4, 2], [4, 0],
                                                            [1, 3], [0, 2], [0, 0]])
      end
    end

    context 'when the supplied piece is a bishop [2, 1]' do
      it 'has the diagonals' do
        expected_moves = [[3, 2], [4, 3], [5, 4], [6, 5], [7, 6], [1, 2], [0, 3], [3, 0], [1, 0]]
        expect(board.possible_moves(piece: bishop)).to eql(expected_moves)
      end
    end

    context 'when the supplied piece is a Queen at [4, 4]' do
      it 'has the correct possible moves' do
        expect(board.possible_moves(piece: queen)).to eql([[4, 5], [4, 6], [4, 7], [4, 3], [4, 2], [4, 1], [4, 0],
                                                           [5, 4], [6, 4], [7, 4], [3, 4], [2, 4], [1, 4], [0, 4],
                                                           [5, 5], [6, 6], [7, 7], [5, 3], [6, 2], [7, 1], [3, 5],
                                                           [2, 6], [1, 7], [3, 3], [2, 2], [1, 1], [0, 0]])
      end
    end

    context 'when the supplied piece is a King at [4, 4]' do
      it 'has the correct possible moves' do
        expect(board.possible_moves(piece: king)).to eql([[4, 5], [4, 3], [5, 4], [3, 4],
                                            [5, 5], [5, 3], [3, 5], [3, 3]])
      end
    end
  end

  describe '#piece_blocking_movement?' do
    context 'when there is no piece in the way' do
      it 'is false' do
        expect(board.piece_blocking_movement?(x: 1, y: 1, target_x: 3, target_y: 3)).to be(false)
      end
    end
  end

  describe '#piece_blocking_movement?' do
    context 'when there is a piece in the way vertically' do
      before do
        board.add_piece(piece: bishop, location: bishop.current_space)
      end
      it 'is false' do
        expect(board.piece_blocking_movement?(x: 1, y: 1, target_x: 3, target_y: 1)).to be(true)
      end
    end
  end

  describe '#piece_blocking_movement?' do
    context 'when there is a piece in the way horizontally' do
      before do
        board.add_piece(piece: Rook.new(x: 1, y: 2, color: 'b'), location: [1, 2])
      end
      it 'is false' do
        expect(board.piece_blocking_movement?(x: 1, y: 1, target_x: 1, target_y: 3)).to be(true)
      end
    end
  end

  describe '#piece_blocking_movement?' do
    context 'when there is a piece in the way diagonally' do
      before do
        board.add_piece(piece: Rook.new(x: 2, y: 2, color: 'b'), location: [2, 2])
      end
      it 'is false' do
        expect(board.piece_blocking_movement?(x: 3, y: 3, target_x: 1, target_y: 1)).to be(true)
      end
    end
  end
end
