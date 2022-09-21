# frozen_string_literal: true

require_relative '../lib/chess'
require_relative '../lib/board'

describe 'Chess' do
  subject(:game) { Chess.new(player1: player1, player2: player2, board: board) }
  let(:player1) { instance_double(Player) }
  let(:player2) { instance_double(Player) }
  let(:board) { Board.new }

  describe '#initialize' do

    it 'has a player1' do
      expect(game.player1).to be(player1)
    end

    it 'has a player2' do
      expect(game.player2).to be(player2)
    end

    it 'has a board' do
      expect(game.board).to be(board)
    end
  end
end