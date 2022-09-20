# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/board'

describe 'Piece' do
  subject(:piece) { Piece.new(x: 2, y: 3, board: board_double) }
  let(:board_double) { instance_double(Board) }

  describe '#initialize' do
    context 'when initializing' do
      it 'has [] for its move array' do
        expect(piece.moves).to eql([])
      end

      it 'has [2,3] for its current_space' do
        expect(piece.current_space).to eql([2, 3])
      end

      it 'returns its board' do
        expect(piece.board).to be(board_double)
      end
    end
  end

  describe '#possible_moves' do
    context 'when it is a generic Piece object' do
      it 'returns an empty array' do
        expect(piece.possible_moves).to eql([])
      end
    end
  end

  describe '#move' do
    context 'when called with the same space' do
      before do
        piece.move(x: 2, y: 3)
      end
      it 'returns the same coordinates' do
        expect(piece.current_space).to eql([2, 3])
      end
    end

    context 'when called with a new space' do
      before do
        piece.move(x: 3, y: 4)
      end

      it 'returns the new coordinates' do
        expect(piece.current_space).to eql([3, 4])
      end
    end
  end
end
