# frozen_string_literal: true

require_relative '../lib/king'
require_relative '../lib/board'

describe 'King' do
  subject(:king) { King.new(x: 4, y: 4, board: board, color: 'b') }
  let(:board) { Board.new }

  describe '#initialize' do
    context 'when piece is a King' do
      it 'has the correct moves' do
        move_set = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]]
        expect(king.moves).to eql(move_set)
      end
    end
  end
end