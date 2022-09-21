# frozen_string_literal: true

# control game set up
class Chess
  attr_reader :player1, :player2, :board

  def initialize(player1:, player2:, board:)
    @player1 = player1
    @player2 = player2
    @board = board
  end
end
