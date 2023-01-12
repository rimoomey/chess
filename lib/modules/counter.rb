module Counter
  include Check

  def self.counts(board:, white_king_location:, black_king_location:)
    [move_count(board: board, white_king_location: white_king_location), capture_count(board: board, white_king_location: white_king_location), check_count(board: board, white_king_location: white_king_location, black_king_location: black_king_location)]
  end

  def self.move_count(board:, white_king_location:)
    count = 0
    board.game_state.each_with_index do |row, row_num|
      row.each_with_index do |piece, col_num|
        place = [row_num, col_num]
        next if piece.instance_of?(Integer)
        next if piece.color != 'w'

        board.possible_moves(piece: piece, place: place).each do |move|
          board.move_piece(start_loc: place, end_loc: move)
          white_king_location = move if piece.instance_of? King
          unless board.check?(location: white_king_location)
            white_king_location = place if piece.instance_of? King
            board.add_piece(piece: piece, location: place)
            board.add_piece(piece: 0, location: move)
            piece.decrement_moves
            count += 1
            next
          end
          white_king_location = place if piece.instance_of? King
          board.add_piece(piece: piece, location: place)
          board.add_piece(piece: 0, location: move)
          piece.decrement_moves
        end
      end
    end
    count
  end

  def self.capture_count(board:, white_king_location:)
    count = 0
    board.game_state.each_with_index do |row, row_num|
      row.each_with_index do |piece, col_num|
        place = [row_num, col_num]
        next if piece.instance_of?(Integer)
        next if piece.color != 'w'

        board.possible_captures(piece: piece, place: place).each do |capture|
          captured_piece = board.game_state[capture[0]][capture[1]]
          board.capture_piece(captor_loc: place, captive_loc: capture)
          white_king_location = capture if piece.instance_of? King
          unless board.check?(location: white_king_location)
            white_king_location = place if piece.instance_of? King
            board.add_piece(piece: captured_piece, location: capture)
            board.add_piece(piece: piece, location: place)
            piece.decrement_moves
            count += 1
            next
          end
          white_king_location = place if piece.instance_of? King
          board.add_piece(piece: captured_piece, location: capture)
          board.add_piece(piece: piece, location: place)
          piece.decrement_moves
        end
      end
    end
    count
  end

  def self.check_count(board:, white_king_location:, black_king_location:)
    count = []
    # check each same-colored piece on the board to see if they can block the check
    board.game_state.each_with_index do |row, row_num|
      row.each_with_index do |piece, col_num|
        next if piece.instance_of?(Integer)
        next if piece.color != 'w'

        count += test_moves(board: board, piece: piece, place: [row_num, col_num], white_king_location: white_king_location, black_king_location: black_king_location)
        count += test_captures(board: board, piece: piece, place: [row_num, col_num], white_king_location: white_king_location, black_king_location: black_king_location)
      end
    end
    count.sum
  end

  def self.test_captures(board:, piece:, place:, white_king_location:, black_king_location:)
    board.possible_captures(piece: piece, place: place).map do |capture|
      test_check_capture(board: board, piece: piece, white_king_location: white_king_location, black_king_location: black_king_location, place: place, to: capture)
    end
  end

  def self.test_moves(board:, piece:, place:, white_king_location:, black_king_location:)
    board.possible_moves(piece: piece, place: place).map do |move|
      test_check_move(board: board, piece: piece, white_king_location: white_king_location, black_king_location: black_king_location, place: place, to: move)
    end
  end

  def self.test_check_move(board:, piece:, white_king_location:, black_king_location:, place:, to:)
    # move the piece to see if the king would be in check, remove afterwards
    board.move_piece(start_loc: place, end_loc: to)
    white_king_location = to if piece.instance_of? King
    if board.check?(location: white_king_location)
      board.add_piece(piece: piece, location: place)
      board.add_piece(piece: 0, location: to)
      piece.decrement_moves
      return 0
    end
    unless board.check?(location: black_king_location)
      board.add_piece(piece: piece, location: place)
      board.add_piece(piece: 0, location: to)
      piece.decrement_moves
      return 0
    end
    board.add_piece(piece: piece, location: place)
    board.add_piece(piece: 0, location: to)
    piece.decrement_moves
    1
  end

  def self.test_check_capture(board:, piece:, white_king_location:, black_king_location:, place:, to:)
    captured_piece = board.game_state[to[0]][to[1]]
    board.capture_piece(captor_loc: place, captive_loc: to)
    white_king_location = to if piece.instance_of? King
    if board.check?(location: white_king_location)
      board.add_piece(piece: captured_piece, location: to)
      board.add_piece(piece: piece, location: place)
      piece.decrement_moves
      return 0
    end
    unless board.check?(location: black_king_location)
      board.add_piece(piece: captured_piece, location: to)
      board.add_piece(piece: piece, location: place)
      piece.decrement_moves
      return 0
    end
    board.add_piece(piece: captured_piece, location: to)
    board.add_piece(piece: piece, location: place)
    piece.decrement_moves
    1
  end
end
