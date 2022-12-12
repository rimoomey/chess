#frozen_string_literal: true

require_relative '../lib/king'
require_relative '../lib/rook'
require_relative '../lib/bishop'
require_relative '../lib/board'
require_relative '../lib/modules/game_state'

describe "Check" do
  subject(:board) { Board.new() }
  let(:king_in_check) { King.new(color: 'b') }
  let(:capturable_pawn) { Pawn.new(color: 'b') }
  let(:rook_checking_king) { Rook.new(color: 'w') }
  let(:bishop_checking_king) { Bishop.new(color: 'w ') }

  describe '#check?' do
    context 'when parameter is not a king but is capturable.' do
      before do
        board.add_piece(piece: capturable_pawn, location: [0, 0])
        board.add_piece(piece: bishop_checking_king, location: [3, 3])
      end
      it 'is false' do
        expect(subject.check?(location: [0, 0])).to be(false);
      end
    end
    context 'when parameter is a king and it is not in check' do
      before do
        board.add_piece(piece: king_in_check, location: [0, 0])
      end
      it 'is false' do
        expect(subject.check?(location: [0, 0])).to be(false);
      end
    end
    context 'when piece is a king and is in check horizontally' do
      before do
        board.add_piece(piece: king_in_check, location: [0, 0])
        board.add_piece(piece: rook_checking_king, location: [0, 2])
      end
      it 'is true' do
        expect(subject.check?(location: [0, 0])).to be(true);
      end
    end
    context 'when piece is a king and is in check diagonally' do
      before do
        board.add_piece(piece: king_in_check, location: [0, 0])
        board.add_piece(piece: bishop_checking_king, location: [2, 2])
      end
      it 'is true' do
        expect(subject.check?(location: [0, 0])).to be(true);
      end
    end
    context 'when piece is a king and could be in check, but it is blocked' do
      before do
        board.add_piece(piece: king_in_check, location: [0, 0])
        board.add_piece(piece: rook_checking_king, location: [2, 2])
        board.add_piece(piece: bishop_checking_king, location: [4, 4])
      end
      it 'is true' do
        expect(subject.check?(location: [0, 0])).to be(false);
      end
    end
  end
end
