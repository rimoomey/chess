#frozen_string_literal: true

require_relative '../lib/pawn'

describe 'Pawn' do
  subject(:pawn) { Pawn.new(x: 2, y: 1, board: board, color: 'W')}
  let(:board) { instance_double(Board) }

  describe '#initialize' do
    context 'when piece is a pawn' do
      it 'has four possible moves, [0, 1] [0, 2], [-1, 1], [1, 1]' do
        expect(pawn.moves).to eql([[0, 1], [0, 2], [-1, 1], [1, 1]])
      end
    end
  end

  describe '#possible_moves' do
    before do
      allow(board).to receive(:in_bounds?).and_return(true).exactly(4).times
    end
    context 'when piece is a pawn' do
      it 'returns the correct moves' do
        expect(pawn.possible_moves).to eql([[2, 2], [2, 3], [1, 2], [3, 2]])
      end
    end
  end
end