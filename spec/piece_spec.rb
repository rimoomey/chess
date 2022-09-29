# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/board'

describe 'Piece' do
  subject(:piece) { Piece.new(color: 'W') }

  describe '#initialize' do
    context 'when initializing' do
      it 'has [] for its move array' do
        expect(piece.moves).to eql([])
      end

      it 'has the correct color' do
        expect(piece.color).to eql('W')
      end
    end
  end
end
