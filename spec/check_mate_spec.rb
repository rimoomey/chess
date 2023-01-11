
describe "CheckMate" do
  subject(:board) { Board.new }
  let(:check_mated_king) { King.new(color: 'b') }
  let(:poser) { Pawn.new(color: 'b') }
  let(:queen1) { Queen.new(color: 'w') }
  let(:queen2) { Queen.new(color: 'w') }
  let(:queen3) { Queen.new(color: 'w') }
  let(:queen4) { Queen.new(color: 'b') }
  let(:queen5) { Queen.new(color: 'b') }
  let(:queen6) { Queen.new(color: 'b') }

  describe "#check_mate?" do
    context "when the king is not in check" do
      before do
        board.add_piece(piece: check_mated_king, location: [0, 4])
      end
      it 'is false' do
        expect(board.check_mate?(king: check_mated_king, location: [0, 4])).to be(false)
      end
    end

    context "when the king is in check_mate but its not a king" do
      before do
        board.add_piece(piece: poser, location: [0, 0])
        board.add_piece(piece: queen1, location: [0, 1])
        board.add_piece(piece: queen2, location: [3, 0])
      end
      it 'is false' do
        expect(board.check_mate?(king: poser, location: [0, 0])).to be(false)
      end
    end

    context "when the king is in check but not check mate" do
      before do
        board.add_piece(piece: check_mated_king, location: [0, 4])
        board.add_piece(piece: queen1, location: [0, 6])
      end
      it 'is false' do
        expect(board.check_mate?(king: check_mated_king, location: [0, 4])).to be(false)
      end
    end
  
    context "when the king is in checkmate" do
      before do
        board.add_piece(piece: check_mated_king, location: [0, 4])
        board.add_piece(piece: queen1, location: [0, 6])
        board.add_piece(piece: queen2, location: [2, 4])
        board.add_piece(piece: queen3, location: [1, 2])
        GameState::pretty_print(board: board)
      end
      it 'is false' do
        expect(board.check_mate?(king: check_mated_king, location: [0, 4])).to be(true)
      end
    end

    context "when the king is in check, can't move out of check, but another piece could guard" do
      before do
        board.add_piece(piece: check_mated_king, location: [0, 0])
        board.add_piece(piece: queen4, location: [1, 0])
        board.add_piece(piece: queen5, location: [0, 1])
        board.add_piece(piece: queen1, location: [3, 3])
        GameState::pretty_print(board: board)
      end
      it 'is false' do
        expect(board.check_mate?(king: check_mated_king, location: [0, 0])).to be(false)
      end
    end

    context "when the king is in check, can't move out of check, but another piece could capture the offending piece" do
      before do
        board.add_piece(piece: check_mated_king, location: [0, 0])
        board.add_piece(piece: queen4, location: [1, 0])
        board.add_piece(piece: queen5, location: [0, 1])
        board.add_piece(piece: queen1, location: [3, 3])
        GameState::pretty_print(board: board)
      end
      it 'is false' do
        expect(board.check_mate?(king: check_mated_king, location: [0, 0])).to be(false)
      end
    end
  end
end