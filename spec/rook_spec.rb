# frozen_string_literal: true

describe 'Rook' do
  subject(:pawn) { Rook.new(color: 'b')}

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
end