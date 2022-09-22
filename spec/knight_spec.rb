# frozen_string_literal: true

require_relative '../lib/knight'
require_relative '../lib/board'

describe 'Knight' do
  subject(:knight) { Knight.new(x: 2, y: 1, board: board, color: 'b') }
  let(:board) { Board.new }

  describe '#initialize' do
    context 'when piece is a Knight' do
      it 'has the correct moves' do
        expect(knight.moves).to eql([[1, 2], [2, 1], [2, -1], [1, -2],
                                     [-1, 2], [-2, 1], [-2, -1], [-1, -2]])
      end
    end
  end
end