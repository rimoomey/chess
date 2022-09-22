# frozen_string_literal: true

require_relative 'pawn'
require_relative 'bishop'
require_relative 'rook'
require_relative 'board'
require_relative 'piece_factory'

# control game set up
class Chess
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
      pawns.push(PieceFactory.for(type: :pawn, x: 1 + time, y: 2, color: 'w'))
      pawns.push(PieceFactory.for(type: :pawn, x: 1 + time, y: 7, color: 'b'))
    end
    pawns.each { |pawn| board.add_piece(piece: pawn) }
  end

  def create_rooks
    rooks = []
    rooks.push(PieceFactory.for(type: :rook, x: 1, y: 1, color: 'w'))
    rooks.push(PieceFactory.for(type: :rook, x: 8, y: 1, color: 'w'))
    rooks.push(PieceFactory.for(type: :rook, x: 1, y: 8, color: 'b'))
    rooks.push(PieceFactory.for(type: :rook, x: 8, y: 8, color: 'b'))

    rooks.each { |rook| board.add_piece(piece: rook) }
  end

  def create_bishops
    bishops = []
    bishops.push(PieceFactory.for(type: :bishop, x: 3, y: 1, color: 'w'))
    bishops.push(PieceFactory.for(type: :bishop, x: 6, y: 1, color: 'w'))
    bishops.push(PieceFactory.for(type: :bishop, x: 3, y: 8, color: 'b'))
    bishops.push(PieceFactory.for(type: :bishop, x: 6, y: 8, color: 'b'))

    bishops.each { |bishop| board.add_piece(piece: bishop) }
  end
end
