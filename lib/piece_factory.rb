# frozen_string_literal: true

require_relative './pieces/pawn'
require_relative './pieces/rook'
require_relative './pieces/knight'
require_relative './pieces/bishop'
require_relative './pieces/queen'
require_relative './pieces/king'
require_relative './pieces/piece'

# piece factory
class PieceFactory
  TYPES = {
    pawn: Pawn,
    bishop: Bishop,
    knight: Knight,
    rook: Rook,
    queen: Queen,
    king: King
  }.freeze

  def self.for(type:, color:)
    (TYPES[type] || Piece).new(color: color)
  end
end
