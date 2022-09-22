# frozen_string_literal: true

require_relative '../lib/queen'
require_relative '../lib/board'

describe 'Queen' do
  subject(:queen) { Queen.new(x: 4, y: 4, board: board, color: 'b') }
  let(:board) { Board.new }

  describe '#initialize' do
    context 'when piece is a Queen' do
      it 'has the correct moves' do
        move_set = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
                    [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7],
                    [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
                    [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0],
                    [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7],
                    [1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7],
                    [-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7],
                    [-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7]]
        expect(queen.moves).to eql(move_set)
      end
    end
  end
end