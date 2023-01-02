# frozen_string_literal: true

describe 'King' do
  subject(:king) { King.new(color: 'b') }

  describe '#initialize' do
    context 'when piece is a King' do
      it 'has the correct moves' do
        move_set = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]]
        expect(king.moves).to eql(move_set)
      end
    end
  end
end