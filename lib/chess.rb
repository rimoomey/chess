# frozen_string_literal: true

require_relative 'piece'
require_relative 'modules/game_state'
require_relative 'board'
require_relative 'piece_factory'

# control game set up
class Chess
  include GameState

  attr_reader :player1, :player2, :board

  def initialize(player1:, player2:, board:)
    @player1 = player1
    @player2 = player2
    @board = board
  end

  def new_game
    create_pawns
    create_rooks
    create_bishops
  end

  private

  def create_pawns
    pawns = []
    8.times do |time|
      pawns.push(PieceFactory.for(type: :pawn, x: 2, y: 1 + time, color: 'w'))
      pawns.push(PieceFactory.for(type: :pawn, x: 7, y: 1 + time, color: 'b'))
    end
    pawns.each { |pawn| board.add_piece(piece: pawn) }
  end

  def create_rooks
    rooks = []
    rooks.push(PieceFactory.for(type: :rook, x: 1, y: 1, color: 'w'))
    rooks.push(PieceFactory.for(type: :rook, x: 1, y: 8, color: 'w'))
    rooks.push(PieceFactory.for(type: :rook, x: 8, y: 1, color: 'b'))
    rooks.push(PieceFactory.for(type: :rook, x: 8, y: 8, color: 'b'))

    rooks.each { |rook| board.add_piece(piece: rook) }
  end

  def create_bishops
    bishops = []
    bishops.push(PieceFactory.for(type: :bishop, x: 1, y: 3, color: 'w'))
    bishops.push(PieceFactory.for(type: :bishop, x: 1, y: 6, color: 'w'))
    bishops.push(PieceFactory.for(type: :bishop, x: 8, y: 3, color: 'b'))
    bishops.push(PieceFactory.for(type: :bishop, x: 8, y: 6, color: 'b'))

    bishops.each { |bishop| board.add_piece(piece: bishop) }
  end
end
