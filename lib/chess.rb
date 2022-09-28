# frozen_string_literal: true

require_relative 'piece'
require_relative 'modules/game_state'
require_relative 'board'
require_relative 'piece_factory'

# control game set up
class Chess
  include GameState

  attr_reader :player1, :player2, :board

  def initialize(player1:, player2:)
    @player1 = player1
    @player2 = player2
    @board = Board.new
  end

  def new_game
    @board = Board.new
    create_pawns
    create_rooks
    create_bishops
  end

  private

  def create_pawns
    pawns = []
    8.times do |time|
      pawns.push(PieceFactory.for(type: :pawn, x: 1, y: time, color: 'w'))
      pawns.push(PieceFactory.for(type: :pawn, x: 6, y: time, color: 'b'))
    end
    pawns.each { |pawn| board.add_piece(piece: pawn, location: pawn.current_space) }
  end

  def create_rooks
    rooks = []
    rooks.push(PieceFactory.for(type: :rook, x: 0, y: 0, color: 'w'))
    rooks.push(PieceFactory.for(type: :rook, x: 0, y: 7, color: 'w'))
    rooks.push(PieceFactory.for(type: :rook, x: 7, y: 0, color: 'b'))
    rooks.push(PieceFactory.for(type: :rook, x: 7, y: 7, color: 'b'))

    rooks.each { |rook| board.add_piece(piece: rook, location: rook.current_space) }
  end

  def create_bishops
    bishops = []
    bishops.push(PieceFactory.for(type: :bishop, x: 0, y: 2, color: 'w'))
    bishops.push(PieceFactory.for(type: :bishop, x: 0, y: 5, color: 'w'))
    bishops.push(PieceFactory.for(type: :bishop, x: 7, y: 2, color: 'b'))
    bishops.push(PieceFactory.for(type: :bishop, x: 7, y: 5, color: 'b'))

    bishops.each { |bishop| board.add_piece(piece: bishop, location: bishop.current_space) }
  end
end
