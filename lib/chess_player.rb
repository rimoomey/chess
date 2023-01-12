# frozen_string_literal: true

# class to manage game loop of a chess game
class ChessPlayer
  include NotationParsing
  include UI

  def start_game
    start_up_prompt
    player1 = prompt_for_name(player_num: 1)
    player2 = prompt_for_name(player_num: 2)
    game = Chess.new(player1: player1, player2: player2)

    game.new_game
    player1_king = { king: game.board.game_state[0][3], location: [0, 3] }
    player2_king = { king: game.board.game_state[7][3], location: [7, 3] }

    GameState.pretty_print(board: game.board)

    play(game: game, king1: player1_king, king2: player2_king)
  end

  private

  def play(game:, king1:, king2:)
    quit_game = false
    check_mate = false
    until quit_game || check_mate
      valid_first_move = false
      valid_second_move = false
      matching_pieces = []

      # prompt for moves phase
      until (valid_first_move && !matching_pieces.empty?) || quit_game
        player1_move = prompt_for_move(player_name: game.player1)
        quit_game = quit?(input: player1_move)
        break if quit_game || check_mate

        valid_first_move = valid_notation?(move: player1_move)
        if valid_first_move
          move1_arr = parse_notation(move: player1_move, color: 'w')
          matching_pieces = search_for_piece(board: game.board, piece_arr: move1_arr)
        end

        invalid_move unless valid_first_move && !matching_pieces.empty?
        next unless valid_first_move

        if matching_pieces.length > 1
          piece_location = ambiguous_choice
          matching_pieces = [disambiguate(moves: matching_pieces, rank_and_file: piece_location)]
        end

        # GameState.pretty_print(board: game.board)
        captured_piece = game.board.game_state[move1_arr[2][0]][move1_arr[2][1]] if move1_arr[1] == 'x'
        perform_move(board: game.board, piece: matching_pieces[0], capture: move1_arr[1], to: move1_arr[2])
        pre_move_king_loc = king1[:location]
        king1[:location] = move1_arr[2] if matching_pieces[0][:piece].instance_of? King

        next unless game.board.check?(location: king1[:location])

        # GameState.pretty_print(board: game.board)
        reverse_move(board: game.board, piece: matching_pieces[0], captured_piece: captured_piece, to: move1_arr[2])
        # GameState.pretty_print(board: game.board)
        king1[:location] = pre_move_king_loc
        no_moving_into_check
        valid_first_move = false
      end

      next if quit_game || check_mate

      captured_piece = game.board.game_state[move1_arr[2][0]][move1_arr[2][1]] if move1_arr[1] == 'x'
      perform_move(board: game.board, piece: matching_pieces[0], capture: move1_arr[1], to: move1_arr[2])
      # if game.board.check?(location: king1[:location])
      #   reverse_move(board: game.board, piece: matching_pieces[0], captured_piece: captured_piece, to: move1_arr[2])
      #   no_moving_into_check
      #   valid_first_move = false
      # end

      king1[:location] = move1_arr[2] if matching_pieces[0][:piece].instance_of? King
      GameState.pretty_print(board: game.board)
      check(player_name: game.player1) if game.board.check?(location: king1[:location])
      check(player_name: game.player2) if game.board.check?(location: king2[:location])
      if game.board.check_mate?(king: king1[:king], location: king1[:location])
        check_mate(loser_name: game.player1, winner_name: game.player2)
        check_mate = true
        break
      end
      if game.board.check_mate?(king: king2[:king], location: king2[:location])
        check_mate(loser_name: game.player2, winner_name: game.player1)
        check_mate = true
        break
      end

      matching_pieces = []

      until (valid_second_move && !matching_pieces.empty?) || quit_game
        player2_move = prompt_for_move(player_name: game.player2)
        quit_game = quit?(input: player2_move)
        break if quit_game || check_mate

        valid_second_move = valid_notation?(move: player2_move)
        if valid_second_move
          move2_arr = parse_notation(move: player2_move, color: 'b')
          matching_pieces = search_for_piece(board: game.board, piece_arr: move2_arr)
        end
        invalid_move unless valid_second_move && !matching_pieces.empty?
      end

      if matching_pieces.length > 1
        piece_location = ambiguous_choice
        matching_pieces = [disambiguate(moves: matching_pieces, rank_and_file: piece_location)]
      end

      next if quit_game || check_mate

      perform_move(board: game.board, piece: matching_pieces[0], capture: move2_arr[1], to: move2_arr[2])
      king2[:location] = move2_arr[2] if matching_pieces[0][:piece].instance_of? King
      GameState.pretty_print(board: game.board)
      check(player_name: game.player2) if game.board.check?(location: king2[:location])
      check(player_name: game.player1) if game.board.check?(location: king1[:location])
      if game.board.check_mate?(king: king1[:king], location: king1[:location])
        check_mate(loser_name: game.player1, winner_name: game.player2)
        check_mate = true
        break
      end
      if game.board.check_mate?(king: king2[:king], location: king2[:location])
        check_mate(loser_name: game.player2, winner_name: game.player1)
        check_mate = true
        break
      end
    end
    thanks_for_playing
  end

  def perform_move(board:, piece:, capture:, to:)
    if capture == 'x'
      board.capture_piece(captor_loc: piece[:loc], captive_loc: to)
    else
      board.move_piece(start_loc: piece[:loc], end_loc: to)
    end
  end

  def reverse_move(board:, piece:, captured_piece:, to:)
    board.add_piece(piece: 0, location: to) if captured_piece.nil?

    board.add_piece(piece: captured_piece, location: to)
    board.add_piece(piece: piece[:piece], location: piece[:loc])
  end

  def search_for_piece(board:, piece_arr:)
    matches = []
    search_piece = piece_arr[0]
    capture = piece_arr[1]
    location = piece_arr[2]
    board.game_state.each_with_index do |row, row_num|
      row.each_with_index do |curr_piece, col_num|
        matches.push({ piece: curr_piece, loc: [row_num, col_num] }) if curr_piece == search_piece
      end
    end
    matching_pieces = []
    if capture == 'x'
      matches.each do |el|
        matching_pieces.push(el) if board.possible_captures(piece: el[:piece], place: el[:loc]).include?(location)
      end
    else
      matches.each do |el|
        matching_pieces.push(el) if board.possible_moves(piece: el[:piece], place: el[:loc]).include?(location)
      end
    end
    matching_pieces
  end
end
