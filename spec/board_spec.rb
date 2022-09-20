# frozen_string_literal: true

require_relative '../lib/board'

describe 'Board' do
  subject(:board) { Board.new }
  describe '#initialize' do
    context 'when a new board is created' do
      it 'has no pieces' do
        expect(board.pieces).to eql([])
      end

      it 'has dimensions of [8, 8]' do
        expect(board.dimensions).to eql([8, 8])
      end
    end
  end
end
