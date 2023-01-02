require_relative './chess'
require_relative './modules/game_state'
require_relative './modules/notation_parsing'

# class to manage game loop of a chess game
class ChessPlayer
  include NotationParsing

  def start_game
    player1 = prompt_for_name(player_num: 1)
    player2 = prompt_for_name(player_num: 2)
    game = Chess.new(player1: player1, player2: player2)

    game.new_game

    GameState.pretty_print(board: game.board)

    game_loop(game: game)
  end

  def game_loop(game:)
    quit_game = false
    until quit_game
      valid_first_move = false
      piece1_to_move = nil
      valid_second_move = false
      piece2_to_move = nil

      # prompt for moves phase
      until (valid_first_move && !piece1_to_move.nil?) || quit_game
        player1_move = prompt_for_move(player_name: game.player1)
        quit_game = quit?(input: player1_move)
        break if quit_game

        valid_first_move = valid_notation?(move: player1_move)
        if valid_first_move
          move1_arr = parse_notation(move: player1_move, color: 'w')
          piece1_to_move = search_for_piece(board: game.board, piece_arr: move1_arr)
        end
        invalid_move unless valid_first_move && !piece1_to_move.nil?
      end

      unless quit_game
        perform_move(board: game.board, piece: piece1_to_move, capture: move1_arr[1], to: move1_arr[2])
        GameState.pretty_print(board: game.board)
      end

      until (valid_second_move && !piece2_to_move.nil?) || quit_game
        player2_move = prompt_for_move(player_name: game.player2)
        quit_game = quit?(input: player2_move)
        break if quit_game

        valid_second_move = valid_notation?(move: player2_move)
        if valid_second_move
          move2_arr = parse_notation(move: player2_move, color: 'b')
          piece2_to_move = search_for_piece(board: game.board, piece_arr: move2_arr)
        end
        invalid_move unless valid_second_move && !piece2_to_move.nil?
      end

      unless quit_game
        perform_move(board: game.board, piece: piece2_to_move, capture: move2_arr[1], to: move2_arr[2])
        GameState.pretty_print(board: game.board)
      end
    end
    thanks_for_playing
  end

  def winner?
    1
  end

  def perform_move(board:, piece:, capture:, to:)
    if capture == 'x'
      board.capture_piece(captor_loc: piece[:loc], captive_loc: to)
    else
      board.move_piece(start_loc: piece[:loc], end_loc: to)
    end
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
    if capture == 'x'
      matches.each do |el|
        return el[:piece] if board.possible_captures(piece: el[:piece], place: el[:loc]).include?(location)
      end
    else
      matches.each do |el|
        return el if board.possible_moves(piece: el[:piece], place: el[:loc]).include?(location)
      end
    end
    nil
  end

  def prompt_for_move(player_name:)
    puts "#{player_name}, what is your move? (q to quit)"
    puts 'Enter in algebraic notation: '
    gets.chomp
  end

  def prompt_for_name(player_num:)
    puts "Player #{player_num}, what is your name?"
    gets.chomp
  end

  def invalid_move
    puts 'please input a legal chess move'
  end

  def thanks_for_playing
    puts 'Thank you for playing!'
  end
end
