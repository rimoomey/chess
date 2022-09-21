# frozen_string_literal: true

require_relative '../lib/bishop'

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

  describe '#possible_moves' do
    context 'from starting space [2, 1], possible moves are correct' do
      before do
        board.add_piece(piece: bishop)
      end

      it 'has the moves [1,2], [3,2] [4,3], [5,4], [6,5], [7,6], [8,7]' do
        expected_moves = [[1, 2], [3, 2], [4, 3], [5, 4], [6, 5], [7, 6], [8, 7]]
        expect(bishop.possible_moves.difference(expected_moves)).to eql([])
      end
    end
  end
end