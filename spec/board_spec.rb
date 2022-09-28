# frozen_string_literal: true

require_relative '../lib/board'

describe 'Board' do
  subject(:board) { Board.new }

  describe '#initialize' do
    context 'when a new board is created' do
      it 'has no pieces' do
        expect(board.pieces).to eql([])
      end


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
        expect(board.in_bounds?(x: 1, y: 2)).to be(true)
      end
    end

    context 'when x is out of bounds' do
      it 'is false' do
        expect(board.in_bounds?(x: 9, y: 2)).to be(false)
      end
    end

    context 'when y is out of bounds' do
      it 'is false' do
        expect(board.in_bounds?(x: 3, y: -9)).to be(false)
      end
    end

    context 'when x and y are out of bounds' do
      it 'is false' do
        expect(board.in_bounds?(x: -2,y: 9)).to be(false)
      end
    end
  end

  describe '#occupied?' do
    context 'when a piece occupies a given space' do
      before do
        board.add_piece(piece: Piece.new(x: 1, y: 1, color: 'b'), location: [1, 1])
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
    let(:piece1) { Piece.new(x: 1, y: 1, color: 'w') }
    let(:piece2) { Piece.new(x: 1, y: 2, color: 'b') }

    context "when there's already a piece there" do
      before do
        board.add_piece(piece: piece1, location: piece1.current_space)
        board.add_piece(piece: piece2, location: piece2.current_space)
      end
      it 'does not move the piece' do
        board.move_piece(piece: piece2, x: 1, y: 1)
        expect(board.game_state[1][2]).to eql(piece2)
      end
    end

    context "when a piece is in the way" do
      before do
        board.add_piece(piece: piece1, location: piece1.current_space)
        board.add_piece(piece: piece2, location: piece2.current_space)
      end
      it 'does not move the piece' do
        board.move_piece(piece: piece2, x: 1, y: 3)
        expect(board.game_state[1][2]).to eql(piece2)
      end
    end

    context "when there is not already a piece there" do
      before do
        board.add_piece(piece: piece1, location: piece1.current_space)
        board.add_piece(piece: piece2, location: piece2.current_space)
      end
      it 'moves the piece' do
        board.move_piece(piece: piece2, x: 2, y: 2)
        expect(board.game_state[2][2]).to eql(piece2)
      end
    end
  end

  describe '#add_piece' do
    context 'when a piece is added to the board' do
      before do
        p = Piece.new(x: 2, y: 3, color: 'w')
        board.add_piece(piece: p, location: p.current_space)
      end
      it 'gets added to game_state[x][y]' do
        expect(board.game_state[2][3]).to eq(Piece.new(x: 2, y: 3, color: 'w'))
      end
    end
  end
end
