# frozen_string_literal: true

# class to manage game loop of a chess game
class ChessPlayer
  include NotationParsing
  include UI

  def start_game
    if start_up_prompt
      load_start
    else
      standard_start
    end
  end

  private

  def play(game:, king1:, king2:)
    GameState.pretty_print(board: game.board) if game.player_one_turn?
    quit_game = false
    until quit_game
      valid_first_move = false
      valid_second_move = false
      matching_pieces = []

      # player 1 turn
      until (valid_first_move && !matching_pieces.empty?) || quit_game || !game.player_one_turn?
        player1_move = prompt_for_move(player_name: game.player1)
        quit_game = quit?(input: player1_move)
        save_game = save?(input: player1_move)

        if save_game
          game.save
          game_saved
          player1_move = prompt_for_move(player_name: game.player1)
          quit_game = quit?(input: player1_move)
        end
        no_new_gameplay if save?(input: player1_move)

        break if quit_game

        valid_first_move = valid_notation?(move: player1_move)
        if valid_first_move
          move1_arr = parse_notation(move: player1_move, color: 'w')
          matching_pieces = search_for_piece(board: game.board, piece_arr: move1_arr)
        end

        invalid_move unless valid_first_move && !matching_pieces.empty?
        next unless valid_first_move && !matching_pieces.empty?

        if matching_pieces.length > 1
          piece_location = ambiguous_choice
          matching_pieces = [disambiguate(moves: matching_pieces, rank_and_file: piece_location)]
        end

        captured_piece = move1_arr[1] == 'x' ? game.board.game_state[move1_arr[2][0]][move1_arr[2][1]] : 0
        perform_move(board: game.board, piece: matching_pieces[0], capture: move1_arr[1], to: move1_arr[2])
        pre_move_king_loc = king1[:location]
        king1[:location] = move1_arr[2] if matching_pieces[0][:piece].instance_of? King
        game.next_turn

        next unless game.board.check?(location: king1[:location])

        reverse_move(board: game.board, piece: matching_pieces[0], captured_piece: captured_piece, to: move1_arr[2])
        game.next_turn
        king1[:location] = pre_move_king_loc
        no_moving_into_check
        valid_first_move = false
      end

      next if quit_game

      GameState.pretty_print(board: game.board) if game.player_two_turn?

      if game.board.check_mate?(king: king1[:king], location: king1[:location])
        check_mate(loser_name: game.player1, winner_name: game.player2)
        break
      end
      if game.board.check_mate?(king: king2[:king], location: king2[:location])
        check_mate(loser_name: game.player2, winner_name: game.player1)
        break
      end
      if game.board.stale_mate?(king: king1[:king], location: king1[:location])
        stale_mate
        break
      end
      if game.board.stale_mate?(king: king2[:king], location: king2[:location])
        stale_mate
        break
      end

      check(player_name: game.player1) if game.board.check?(location: king1[:location])
      check(player_name: game.player2) if game.board.check?(location: king2[:location])

      matching_pieces = []

      # player 2 turn
      until (valid_second_move && !matching_pieces.empty?) || quit_game || !game.player_two_turn?
        player2_move = prompt_for_move(player_name: game.player2)
        quit_game = quit?(input: player2_move)

        if save?(input: player2_move)
          game_saved
          game.save
          player2_move = prompt_for_move(player_name: game.player2)
          quit_game = quit?(input: player2_move)
        end
        no_new_gameplay if save?(input: player2_move)

        break if quit_game

        valid_second_move = valid_notation?(move: player2_move)
        if valid_second_move
          move2_arr = parse_notation(move: player2_move, color: 'b')
          matching_pieces = search_for_piece(board: game.board, piece_arr: move2_arr)
        end
        invalid_move unless valid_second_move && !matching_pieces.empty?
        next unless valid_second_move && !matching_pieces.empty?

        if matching_pieces.length > 1
          piece_location = ambiguous_choice
          matching_pieces = [disambiguate(moves: matching_pieces, rank_and_file: piece_location)]
        end

        captured_piece = move2_arr[1] == 'x' ? game.board.game_state[move2_arr[2][0]][move2_arr[2][1]] : 0
        perform_move(board: game.board, piece: matching_pieces[0], capture: move2_arr[1], to: move2_arr[2])
        pre_move_king_loc = king2[:location]
        king2[:location] = move2_arr[2] if matching_pieces[0][:piece].instance_of? King
        game.next_turn

        next unless game.board.check?(location: king2[:location])

        reverse_move(board: game.board, piece: matching_pieces[0], captured_piece: captured_piece, to: move2_arr[2])
        game.next_turn
        king2[:location] = pre_move_king_loc
        no_moving_into_check
        valid_second_move = false
      end

      next if quit_game

      GameState.pretty_print(board: game.board) if game.player_one_turn?

      if game.board.check_mate?(king: king1[:king], location: king1[:location])
        check_mate(loser_name: game.player1, winner_name: game.player2)
        break
      end
      if game.board.check_mate?(king: king2[:king], location: king2[:location])
        check_mate(loser_name: game.player2, winner_name: game.player1)
        break
      end
      if game.board.stale_mate?(king: king1[:king], location: king1[:location])
        stale_mate
        break
      end
      if game.board.stale_mate?(king: king2[:king], location: king2[:location])
        stale_mate
        break
      end

      check(player_name: game.player2) if game.board.check?(location: king2[:location])
      check(player_name: game.player1) if game.board.check?(location: king1[:location])
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
    piece[:piece].decrement_moves
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

  def standard_start
    player1 = prompt_for_name(player_num: 1)
    player2 = prompt_for_name(player_num: 2)
    game = Chess.new(player1: player1, player2: player2)

    game.new_game
    player1_king = { king: game.board.game_state[0][3], location: [0, 3] }
    player2_king = { king: game.board.game_state[7][3], location: [7, 3] }

    game.save

    play(game: game, king1: player1_king, king2: player2_king)
  end

  def load_start
    begin
      game = Saving.load
    rescue TypeError
      no_save_file
      standard_start
    end

    player1_king = find_kings(board: game.board).filter { |e| e[:king].color == 'w' }.first
    player2_king = find_kings(board: game.board).filter { |e| e[:king].color == 'b' }.first

    play(game: game, king1: player1_king, king2: player2_king)
  end

  def find_kings(board:)
    kings = []
    board.game_state.each_with_index do |row, row_num|
      row.each_with_index do |curr_piece, col_num|
        kings.push({ king: curr_piece, location: [row_num, col_num] }) if curr_piece.instance_of? King
      end
    end
    kings
  end
end
