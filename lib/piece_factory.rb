# frozen_string_literal: true

require_relative 'pawn'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'

# piece factory
class PieceFactory
  TYPES = {
    pawn: Pawn,
    bishop: Bishop,
    #knight: Knight,
    rook: Rook#,
    #queen: queen,
    #king: king
  }.freeze

  def self.for(type:, x:, y:, color:)
    (TYPES[type] || Piece).new(x: x, y: y, color: color)
  end
end
