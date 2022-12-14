# frozen_string_literal: true

require_relative '../config/environment'

describe 'Bishop' do
  subject(:bishop) { Bishop.new(color: 'b') }

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
