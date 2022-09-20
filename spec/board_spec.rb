# frozen_string_literal: true

require_relative '../lib/board'

describe 'Board' do
  subject(:board) { Board.new }
  describe '#initialize' do
    context 'when a new board is created' do
      it 'has no pieces' do
        expect(board.pieces).to eql([])
      end
    end
  end
end
