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

  describe '#possible_moves' do
    context 'when piece is a Queen' do
      it 'has the correct possible moves' do
        expect(queen.possible_moves).to eql([[4, 5], [4, 6], [4, 7], [4, 8], [4, 3],
                                            [4, 2], [4, 1], [5, 4], [6, 4], [7, 4],
                                            [8, 4], [3, 4], [2, 4], [1, 4], [5, 5],
                                            [6, 6], [7, 7], [8, 8], [5, 3],
                                            [6, 2], [7, 1], [3, 5], [2, 6],
                                            [1, 7], [3, 3], [2, 2], [1, 1]])
      end
    end
  end
end