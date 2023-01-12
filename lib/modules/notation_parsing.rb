# frozen_string_literal: true

# module to parse algebraic notation for a chess game
module NotationParsing
  def quit?(input:)
    return true if input.downcase == 'q'

    false
  end

  def save?(input:)
    return true if input.downcase == 's'

    false
  end

  def valid_notation?(move:)
    move.scan(/\A[KQRBN]?x?[a-h][1-8]/).include?(move)
  end

  def disambiguate(moves:, rank_and_file:)
    return nil if rank_and_file.scan(/\A[a-h][1-8]/).nil?

    moves.each do |piece|
      return piece if piece[:loc] == parse_location(loc: rank_and_file.scan(/\A[a-h][1-8]/)[0])
    end

    nil
  end

  def parse_notation(move:, color:)
    piece = parse_piece(piece_notation: move.scan(/\A[KQRBN]?/)[0], color: color)
    capture = move.scan(/x/)[0].nil? ? '' : 'x'
    location = parse_location(loc: move.scan(/[a-h][1-8]/)[0])
    [piece, capture, location]
  end

  def parse_piece(piece_notation:, color:)
    case piece_notation
    when 'K'
      King.new(color: color)
    when 'Q'
      Queen.new(color: color)
    when 'R'
      Rook.new(color: color)
    when 'B'
      Bishop.new(color: color)
    when 'N'
      Knight.new(color: color)
    else
      Pawn.new(color: color)
    end
  end

  def parse_location(loc:)
    location = []
    location.push(loc.scan(/[a-h]/)[0])
    location.push(loc.scan(/[1-8]/)[0])

    case location[0]
    when 'a'
      location[0] = 0
    when 'b'
      location[0] = 1
    when 'c'
      location[0] = 2
    when 'd'
      location[0] = 3
    when 'e'
      location[0] = 4
    when 'f'
      location[0] = 5
    when 'g'
      location[0] = 6
    when 'h'
      location[0] = 7
    end

    location[1] = location[1].to_i - 1

    [location[1], location[0]]
  end
end
