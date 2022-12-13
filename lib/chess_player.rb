require_relative './chess'
require_relative './modules/game_state'
require_relative './modules/notation_parsing'

# class to manage game loop of a chess game
class ChessPlayer
  include NotationParsing

  def start_game
    game = Chess.new(player1: 'Bob', player2: 'Linda')

    game.new_game

    GameState.pretty_print(board: game.board)

    game_loop(game: game)
  end

  def game_loop(game:)
    count = 0
    until count.positive?
      valid_first_move = false
      piece1_to_move = nil
      valid_second_move = false
      piece2_to_move = nil

      # prompt for moves phase
      until valid_first_move && !piece1_to_move.nil?
        player1_move = prompt_for_move(player_name: game.player1)
        valid_first_move = valid_notation?(move: player1_move)
        move1_arr = parse_notation(move: player1_move, color: 'w')
        piece1_to_move = search_for_piece(board: game.board, piece_arr: move1_arr)
        invalid_move unless valid_first_move && !piece1_to_move.nil?
      end

      perform_move(board: game.board, piece: piece1_to_move, capture: move1_arr[1], to: move1_arr[2])
      GameState.pretty_print(board: game.board)

      until valid_second_move && !piece2_to_move.nil?
        player2_move = prompt_for_move(player_name: game.player2)
        valid_second_move = valid_notation?(move: player2_move)
        move2_arr = parse_notation(move: player2_move, color: 'b')
        piece2_to_move = search_for_piece(board: game.board, piece_arr: move2_arr)
        invalid_move unless valid_second_move && !piece2_to_move.nil?
      end

      perform_move(board: game.board, piece: piece2_to_move, capture: move2_arr[1], to: move2_arr[2])
      GameState.pretty_print(board: game.board)

      count += winner?
    end
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

  # def valid_notation?(move:)
  #   move.scan(/\A[KQRBN]?x?[a-h][1-8]/).include?(move)
  # end

  # def parse_notation(move:, color:)
  #   piece = parse_piece(piece_notation: move.scan(/\A[KQRBN]?/)[0], color: color)
  #   capture = !move.scan(/x?/)[0].nil?
  #   location = parse_location(loc: move.scan(/[a-h][1-8]/)[0])
  #   [piece, capture, location]
  # end

  # def parse_piece(piece_notation:, color:)
  #   case piece_notation
  #   when 'K'
  #     King.new(color: color)
  #   when 'Q'
  #     Queen.new(color: color)
  #   when 'R'
  #     Rook.new(color: color)
  #   when 'B'
  #     Bishop.new(color: color)
  #   when 'N'
  #     Knight.new(color: color)
  #   else
  #     Pawn.new(color: color)
  #   end
  # end

  # def parse_location(loc:)
  #   location = []
  #   location.push(loc.scan(/[a-h]/)[0])
  #   location.push(loc.scan(/[1-8]/)[0])

  #   case location[0]
  #   when 'a'
  #     location[0] = 0
  #   when 'b'
  #     location[0] = 1
  #   when 'c'
  #     location[0] = 2
  #   when 'd'
  #     location[0] = 3
  #   when 'e'
  #     location[0] = 4
  #   when 'f'
  #     location[0] = 5
  #   when 'g'
  #     location[0] = 6
  #   when 'h'
  #     location[0] = 7
  #   end

  #   location[1] = location[1].to_i - 1

  #   [location[1], location[0]]
  # end

  def search_for_piece(board:, piece_arr:)
    matches = []
    search_piece = piece_arr[0]
    capture = piece_arr[1]
    location = piece_arr[2]
    p location
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
    puts "#{player_name}, what is your move?"
    puts 'Enter in algebraic notation: '
    gets.chomp
  end

  def invalid_move
    puts 'please input a legal chess move'
  end
end
