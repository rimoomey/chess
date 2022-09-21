# frozen_string_literal: true

# chess player
class Player
  attr_reader :color, :captures

  def initialize(color:, captures: [])
    @color = color
    @captures = captures
  end

  def capture(piece:)
    captures.push(piece)
  end
end
