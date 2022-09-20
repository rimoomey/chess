# frozen_string_literal: true

require_relative '../lib/piece'

describe 'Piece' do
  describe '#initialize' do
    subject(:piece) { Piece.new(x: 2, y: 3) }
    context 'when initializing' do
      it 'has [] for its move array' do
        expect(piece.moves).to eql([])
      end

      it 'has [2,3] for its current_space' do
        expect(piece.current_space).to eql([2, 3])
      end
    end
  end
end
