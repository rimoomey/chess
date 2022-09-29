# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/rook'
require_relative '../lib/queen'

describe 'Board' do
  subject(:board) { Board.new }

  describe '#initialize' do
    context 'when a new board is created' do
      it 'has a 2x2 game_state array full of 0s' do
        expect(board.game_state).to eql([[0, 0, 0, 0, 0, 0, 0, 0],
                                         [0, 0, 0, 0, 0, 0, 0, 0],
                                         [0, 0, 0, 0, 0, 0, 0, 0],
                                         [0, 0, 0, 0, 0, 0, 0, 0],
                                         [0, 0, 0, 0, 0, 0, 0, 0],
                                         [0, 0, 0, 0, 0, 0, 0, 0],
                                         [0, 0, 0, 0, 0, 0, 0, 0],
                                         [0, 0, 0, 0, 0, 0, 0, 0]])
      end
    end
  end

  describe '#in_bounds?' do
    context 'when an index is within board dimensions' do
      it 'is true' do
        expect(board.in_bounds?(point: [1, 2])).to be(true)
      end
    end

    context 'when x is out of bounds' do
      it 'is false' do
        expect(board.in_bounds?(point: [8, 2])).to be(false)
      end
    end

    context 'when y is out of bounds' do
      it 'is false' do
        expect(board.in_bounds?(point: [3, -1])).to be(false)
      end
    end

    context 'when x and y are out of bounds' do
      it 'is false' do
        expect(board.in_bounds?(point: [-2, 8])).to be(false)
      end
    end
  end

  describe '#occupied?' do
    context 'when a piece occupies a given space' do
      before do
        board.add_piece(piece: Piece.new(color: 'b'), location: [1, 1])
      end

      it 'returns true' do
        expect(board.occupied?(x: 1, y: 1)).to be(true)
      end
    end

    context 'when a piece does not occupy a given space' do
      it 'returns false' do
        expect(board.occupied?(x: 5, y: 4)).to be(false)
      end
    end
  end

  describe '#move_piece' do
    let(:piece1) { Queen.new(color: 'w') }
    let(:piece2) { Rook.new(color: 'b') }

    context "when there's already a piece there" do
      before do
        board.add_piece(piece: piece1, location: [1, 1])
        board.add_piece(piece: piece2, location: [1, 2])
      end
      it 'does not move the piece' do
        board.move_piece(start_loc: [1, 2], end_loc: [1, 1])
        expect(board.game_state[1][2]).to eql(piece2)
      end
    end

    context "when a piece is in the way" do
      before do
        board.add_piece(piece: piece1, location: [1, 1])
        board.add_piece(piece: piece2, location: [1, 2])
      end
      it 'does not move the piece' do
        board.move_piece(start_loc: [1, 1], end_loc: [1, 3])
        expect(board.game_state[1][2]).to eql(piece2)
      end
    end

    context "when there is not already a piece there" do
      before do
        board.add_piece(piece: piece1, location: [1, 1])
        board.add_piece(piece: piece2, location: [1 ,2])
      end
      it 'moves the piece' do
        board.move_piece(start_loc: [1, 1], end_loc: [2, 2])
        expect(board.game_state[2][2]).to eql(piece1)
      end
    end
  end

  describe '#add_piece' do
    context 'when a piece is added to the board' do
      before do
        p = Rook.new(color: 'w')
        board.add_piece(piece: p, location: [2, 3])
      end
      it 'gets added to game_state[x][y]' do
        expect(board.game_state[2][3]).to eq(Rook.new(color: 'w'))
      end
    end
  end
end
