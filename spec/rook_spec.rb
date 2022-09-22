# frozen_string_literal: true

require_relative '../lib/rook'

describe 'Rook' do
  subject(:pawn) { Rook.new(x: 2, y: 1, board: board, color: 'B')}
  let(:board) { Board.new }

  describe '#initialize' do
    context 'when piece is a rook' do
      it 'has the correct verticle and horizontal moves' do
        expect(pawn.moves).to eql([[0, 1], [0, 2], [0, 3], [0, 4], [0, 5],
                                   [0, 6], [0, 7], [0, -1], [0, -2], [0, -3],
                                   [0, -4], [0, -5], [0, -6], [0, -7], [1, 0],
                                   [2, 0], [3, 0], [4, 0], [5, 0], [6, 0],
                                   [7, 0], [-1, 0], [-2, 0], [-3, 0], [-4, 0],
                                   [-5, 0], [-6, 0], [-7, 0]])
      end
    end
  end

  describe '#possible_moves' do
    context 'when piece is a rook at [2, 1]' do
      it 'returns the correct moves' do
        expected_moves = [[2, 2], [2, 3], [2, 4], [2, 5],
                          [2, 6], [2, 7], [2, 8], [1, 1],
                          [3, 1], [4, 1], [5, 1], [6, 1],
                          [7, 1], [8, 1]]
        expect(pawn.possible_moves.difference(expected_moves)).to eql([])
      end
    end
  end
end