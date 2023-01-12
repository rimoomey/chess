require_relative '../config/environment'

describe "Count" do
  subject(:game) { Chess.new(player1: 'test1', player2: 'test2') }
  let(:position1) { Saving.load('./config/position1.yml').board }
  let(:counts1) { Counter.counts(board: position1, white_king_location: [0, 3], black_king_location: [7, 3]) }
  let(:position2) { Saving.load('./config/position2.yml').board }
  let(:counts2) { Counter.counts(board: position2, white_king_location: [0, 3], black_king_location: [7, 3]) }
  let(:position3) { Saving.load('./config/position3.yml').board }
  let(:counts3) { Counter.counts(board: position3, white_king_location: [4, 7], black_king_location: [3, 0]) }

  describe "#move_count" do
    context 'at the initial position' do
      it 'has 20 legal moves' do
        expect(counts1[0] + counts1[1]).to be(20)
      end

      it 'has 0 legal captures' do
        expect(counts1[1]).to be(0)
      end

      it 'has 0 legal checks' do
        expect(counts1[2]).to be(0)
      end
    end

    context 'at position 2 described at (https://www.chessprogramming.org/Perft_Results#Summary)' do
      it 'has 46 legal moves' do
        expect(counts2[0] + counts2[1]).to be(46)
      end
  
      it 'has 8 legal captures' do
        expect(counts2[1]).to be(8)
      end
  
      it 'has 0 legal checks' do
        expect(counts2[2]).to be(0)
      end
    end

    context 'at position 3 described at (https://www.chessprogramming.org/Perft_Results#Summary)' do
      it 'has 14 legal moves' do
        expect(counts3[0] + counts3[1]).to be(14)
      end

      it 'has 1 legal captures' do
        expect(counts3[1]).to be(1)
      end

      it 'has 2 legal checks' do
        expect(counts3[2]).to be(2)
      end
    end
  end
end