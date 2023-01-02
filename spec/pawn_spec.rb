#frozen_string_literal: true

describe 'Pawn' do
  subject(:w_pawn) { Pawn.new(color: 'w')}
  subject(:b_pawn) { Pawn.new(color: 'b')}

  describe '#initialize' do
    context 'when piece is a white pawn' do
      it 'has four possible moves, [1, 0] [2, 0], [1, -1], [1, 1]' do
        expect(w_pawn.moves).to eql([[1, 0], [2, 0]])
      end
    end

    context 'when piece is a black pawn' do
      it 'has four opposite moves, [-1, 0], [-2, 0], [-1, -1], [-1, 1]' do
        expect(b_pawn.moves).to eql([[-1, 0], [-2, 0]])
      end
    end
  end
end