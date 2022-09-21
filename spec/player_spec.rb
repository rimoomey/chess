# frozen_string_literal: true

require_relative '../lib/player'

describe 'Player' do
  subject(:player) { Player.new(color: 'white', captures: [piece1]) }
  let(:piece1) { instance_double(Piece) }
  let(:piece2) { instance_double(Piece) }

  describe '#initialize' do
    it 'returns the player color' do
      expect(player.color).to eql('white')
    end

    it 'returns the capture list' do
      expect(player.captures).to eql([piece1])
    end
  end

  describe '#capture' do
    it 'adds captured piece to captures' do
      player.capture(piece: piece2)
      expect(player.captures).to eql([piece1, piece2])
    end
  end
end