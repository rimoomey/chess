#frozen_string_literal: true

require_relative '../lib/pawn'

describe 'Pawn' do
  subject(:pawn) { Pawn.new(x: 2, y: 1, color: 'w')}

  describe '#initialize' do
    context 'when piece is a white pawn' do
      it 'has four possible moves, [1, 0] [2, 0], [1, -1], [1, 1]' do
        expect(pawn.moves).to eql([[1, 0], [2, 0], [1, -1], [1, 1]])
      end
    end

    context 'when piece is a black pawn' do
      it 'has four opposite moves, [-1, 0], [-2, 0], [-1, -1], [-1, 1]' do
        expect(pawn.moves).to eql([[1, 0], [2, 0], [1, -1], [1, 1]])
      end
    end
  end
end