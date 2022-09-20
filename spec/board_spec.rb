# frozen_string_literal: true

require_relative '../lib/board'

describe 'Board' do
  subject(:board) { Board.new }
  describe '#initialize' do
    context 'when a new board is created' do
      it 'has no pieces' do
        expect(board.pieces).to eql([])
      end

      it 'has dimensions of [8, 8]' do
        expect(board.dimensions).to eql([8, 8])
      end
    end
  end

  describe '#in_bounds?' do
    context 'when an index is within board dimensions' do
      it 'is true' do
        expect(board.in_bounds?([1, 2])).to be(true)
      end
    end

    context 'when x is out of bounds' do
      it 'is false' do
        expect(board.in_bounds?([9, 2])).to be(false)
      end
    end

    context 'when y is out of bounds' do
      it 'is false' do
        expect(board.in_bounds?([3, -9])).to be(false)
      end
    end

    context 'when x and y are out of bounds' do
      it 'is false' do
        expect(board.in_bounds?([-2, 9])).to be(false)
      end
    end
  end
end
