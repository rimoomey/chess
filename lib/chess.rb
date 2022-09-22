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
    PieceFactory::TYPES.each do |key, type|
      if type == Pawn
        pawns = []
        8.times do |time|
          pawns.push(PieceFactory.for(type: key, x: 1 + time, y: 2, board: board, color: 'w'))
          pawns.push(PieceFactory.for(type: key, x: 1 + time, y: 7, board: board, color: 'b'))
        end
        pawns.each { |pawn| board.add_piece(piece: pawn) }

      elsif type == Rook
        rooks = []
        rooks.push(PieceFactory.for(type: key, x: 1, y: 1, board: board, color: 'w'))
        rooks.push(PieceFactory.for(type: key, x: 8, y: 1, board: board, color: 'w'))
        rooks.push(PieceFactory.for(type: key, x: 1, y: 8, board: board, color: 'b'))
        rooks.push(PieceFactory.for(type: key, x: 8, y: 8, board: board, color: 'b'))

        rooks.each { |rook| board.add_piece(piece: rook) }

      elsif type == Bishop
        bishops = []
        bishops.push(PieceFactory.for(type: key, x: 3, y: 1, board: board, color: 'w'))
        bishops.push(PieceFactory.for(type: key, x: 6, y: 1, board: board, color: 'w'))
        bishops.push(PieceFactory.for(type: key, x: 3, y: 8, board: board, color: 'b'))
        bishops.push(PieceFactory.for(type: key, x: 6, y: 8, board: board, color: 'b'))

        bishops.each { |bishop| board.add_piece(piece: bishop) }
      end
    end
  end
end
