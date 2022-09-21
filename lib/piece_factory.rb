# frozen_string_literal: true

require_relative 'pawn'
require_relative 'bishop'

# piece factory
class PieceFactory
  TYPES = {
    pawn: Pawn,
    bishop: Bishop
    #knight: Knight,
    #rook: Rook,
    #queen: queen,
    #king: king
  }.freeze

  def self.for(type:, x:, y:, board:, color:)
    (TYPES[type] || Piece).new(x: x, y: y, board: board, color: color)
  end
end
