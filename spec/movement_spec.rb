# frozen_string_literal: true

require_relative '../lib/modules/movement'
require_relative '../lib/board'

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
      it 'returns two possible moves' do
        expect(board.possible_moves(piece: pawn)).to eql([[1, 2], [1, 3], [2, 2]])
      end
    end

    context 'when the supplied piece is a rook' do
      it 'returns the entire row and entire column' do
        expect(board.possible_moves(piece: rook)).to eql([[1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
                                                          [1, 8], [2, 1], [3, 1], [4, 1], [5, 1], [6, 1],
                                                          [7, 1], [8, 1]])
      end
    end

    context 'when the supplied piece is a knight' do
      it 'has the correct possible moves' do
        expect(board.possible_moves(piece: knight)).to eql([[3, 3], [4, 2], [1, 3]])
      end
    end

    context 'when the supplied piece is a bishop [2, 1]' do
      it 'has the moves [1,2], [3,2] [4,3], [5,4], [6,5], [7,6], [8,7]' do
        expected_moves = [[3, 2], [4, 3], [5, 4], [6, 5], [7, 6], [8, 7], [1, 2]]
        expect(board.possible_moves(piece: bishop)).to eql(expected_moves)
      end
    end

    context 'when the supplied piece is a Queen at [4, 4]' do
      it 'has the correct possible moves' do
        expect(board.possible_moves(piece: queen)).to eql([[4, 5], [4, 6], [4, 7], [4, 8], [4, 3],
                                            [4, 2], [4, 1], [5, 4], [6, 4], [7, 4],
                                            [8, 4], [3, 4], [2, 4], [1, 4], [5, 5],
                                            [6, 6], [7, 7], [8, 8], [5, 3],
                                            [6, 2], [7, 1], [3, 5], [2, 6],
                                            [1, 7], [3, 3], [2, 2], [1, 1]])
      end
    end

    context 'when the supplied piece is a King at [4, 4]' do
      it 'has the correct possible moves' do
        expect(board.possible_moves(piece: king)).to eql([[4, 5], [4, 3], [5, 4], [3, 4],
                                            [5, 5], [5, 3], [3, 5], [3, 3]])
      end
    end
  end
end