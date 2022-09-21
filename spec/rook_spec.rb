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
    context 'when piece is a pawn' do
      xit 'returns the correct moves' do
        expect(pawn.possible_moves).to eql([[2, 2], [2, 3], [1, 2], [3, 2]])
      end
    end
  end
end