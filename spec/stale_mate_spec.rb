
describe StaleMate do
  subject(:board) { Board.new }
  let(:stale_mated_king) { King.new(color: 'b') }
  let(:b_pawn) { Pawn.new(color: 'b') }
  let(:w_pawn) { Pawn.new(color: 'w') }
  let(:w_rook) { Rook.new(color: 'w') }
  let(:w_bishop) { Bishop.new(color: 'w') }
  let(:w_queen) { Queen.new(color: 'w') }
  let(:b_queen) { Queen.new(color: 'b') }

  context "when the entire board is full, but the king is not in check" do
    before do
      board.game_state = board.game_state.map do |row|
        row.map do |piece|
          b_pawn
        end
      end
      board.add_piece(piece: stale_mated_king, location: [3, 3])
    end
    it 'is false' do
      expect(board.stale_mate?(king: stale_mated_king, location: [3, 3])).to be(true)
    end
  end

  context "when there are no valid moves, but the king is not in check" do
    before do
      board.add_piece(piece: stale_mated_king, location: [3, 3])
      board.add_piece(piece: w_queen, location: [0, 2])
      board.add_piece(piece: w_queen, location: [2, 7])
      board.add_piece(piece: w_queen, location: [4, 0])
      board.add_piece(piece: w_queen, location: [7, 4])
    end
    it 'is false' do
      expect(board.stale_mate?(king: stale_mated_king, location: [3, 3])).to be(true)
    end
  end

  context "when there are no valid moves and a different configuration, but the king is not in check" do
    before do
      board.add_piece(piece: stale_mated_king, location: [0, 3])
      board.add_piece(piece: w_pawn, location: [0, 2])
      board.add_piece(piece: w_pawn, location: [0, 4])
      board.add_piece(piece: w_pawn, location: [0, 0])
      board.add_piece(piece: w_pawn, location: [0, 1])
      board.add_piece(piece: w_pawn, location: [0, 5])
      board.add_piece(piece: w_pawn, location: [0, 6])
      board.add_piece(piece: w_pawn, location: [0, 7])
      board.add_piece(piece: w_pawn, location: [1, 0])
      board.add_piece(piece: w_pawn, location: [1, 1])
      board.add_piece(piece: w_pawn, location: [1, 5])
      board.add_piece(piece: w_pawn, location: [1, 6])
      board.add_piece(piece: w_pawn, location: [1, 7])
      board.add_piece(piece: w_rook, location: [7, 2])
      board.add_piece(piece: w_rook, location: [7, 4])
      board.add_piece(piece: w_bishop, location: [5, 7])
    end
    it 'is false' do
      expect(board.stale_mate?(king: stale_mated_king, location: [0, 3])).to be(true)
    end
  end

  context "same situation, but a single black piece has a move" do
    before do
      board.add_piece(piece: stale_mated_king, location: [0, 3])
      board.add_piece(piece: w_pawn, location: [0, 2])
      board.add_piece(piece: w_pawn, location: [0, 4])
      board.add_piece(piece: w_pawn, location: [0, 0])
      board.add_piece(piece: w_pawn, location: [0, 1])
      board.add_piece(piece: w_pawn, location: [0, 5])
      board.add_piece(piece: w_pawn, location: [0, 6])
      board.add_piece(piece: w_pawn, location: [0, 7])
      board.add_piece(piece: w_pawn, location: [1, 0])
      board.add_piece(piece: w_pawn, location: [1, 1])
      board.add_piece(piece: w_pawn, location: [1, 5])
      board.add_piece(piece: w_pawn, location: [1, 6])
      board.add_piece(piece: w_pawn, location: [1, 7])
      board.add_piece(piece: w_rook, location: [7, 2])
      board.add_piece(piece: w_rook, location: [7, 4])
      board.add_piece(piece: w_bishop, location: [5, 7])
      board.add_piece(piece: b_pawn, location: [7, 0])
    end
    it 'is false' do
      expect(board.stale_mate?(king: stale_mated_king, location: [0, 3])).to be(false)
    end
  end
end