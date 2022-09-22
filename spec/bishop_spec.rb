# frozen_string_literal: true

require_relative '../lib/bishop'
require_relative '../lib/board'

describe 'Bishop' do
  subject(:bishop) { Bishop.new(x: 2, y: 1, board: board, color: 'black') }
  let(:board) { Board.new }

  describe '#initialize' do
    context 'when piece is a bishop' do
      it 'has the following possible moves [+-1, +-1],...[+-7, +-7]' do
        expect(bishop.moves).to eql([[1, 1], [2, 2], [3, 3], [4, 4],
                                     [5, 5], [6, 6], [7, 7], [-1, 1],
                                     [-2, 2], [-3, 3], [-4, 4], [-5, 5],
                                     [-6, 6], [-7, 7], [1, -1], [2, -2],
                                     [3, -3], [4, -4], [5, -5], [6, -6],
                                     [7, -7], [-1, -1], [-2, -2], [-3, -3],
                                     [-4, -4], [-5, -5], [-6, -6], [-7, -7]])
      end
    end
  end
end