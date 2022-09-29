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
    8.times do |time|
      board.add_piece(piece: PieceFactory.for(type: :pawn, color: 'w'), location: [1, time])
      board.add_piece(piece: PieceFactory.for(type: :pawn, color: 'b'), location: [6, time])
    end
  end

  def create_rooks
    board.add_piece(piece: PieceFactory.for(type: :rook, color: 'w'), location: [0, 0])
    board.add_piece(piece: PieceFactory.for(type: :rook, color: 'w'), location: [0, 7])
    board.add_piece(piece: PieceFactory.for(type: :rook, color: 'b'), location: [7, 0])
    board.add_piece(piece: PieceFactory.for(type: :rook, color: 'b'), location: [7, 7])
  end

  def create_bishops
    board.add_piece(piece: PieceFactory.for(type: :bishop, color: 'w'), location: [0, 2])
    board.add_piece(piece: PieceFactory.for(type: :bishop, color: 'w'), location: [0, 5])
    board.add_piece(piece: PieceFactory.for(type: :bishop, color: 'b'), location: [7, 2])
    board.add_piece(piece: PieceFactory.for(type: :bishop, color: 'b'), location: [7, 5])
  end
end
