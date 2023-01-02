# frozen_string_literal: true

describe 'Knight' do
  subject(:knight) { Knight.new(color: 'b') }

  describe '#initialize' do
    context 'when piece is a Knight' do
      it 'has the correct moves' do
        expect(knight.moves).to eql([[1, 2], [2, 1], [2, -1], [1, -2],
                                     [-1, 2], [-2, 1], [-2, -1], [-1, -2]])
      end
    end
  end
end