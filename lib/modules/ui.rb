# frozen_string_literal: true

module UI
  def start_up_prompt
    puts "    ____   _   _   ____  _____   _____ \n" \
         "   //     //  //  //    //      //    \n" \
         "  //     //__//  //__  //___   //___ \n" \
         " //     //  //  //        //      // \n" \
         "//___  //  //  //__  ____//  ____//\n\n\n"

    puts "Welcome to Ruby Chess! Chess is a game that is meant to be played by two players.\n" \
         "All moves are recorded in algebraic notation for chess.\n\n" \
         "To read about algebraic notation, please visit this Wikipedia article:\n" \
         "https://en.wikipedia.org/wiki/Algebraic_notation_(chess)\n\n" \
         "You may save your game at any time by typing 's' or quit by typing 'q'\n\n\n"
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

  def no_moving_into_check
    puts 'You cannot move into check'
  end

  def check(player_name:)
    puts "#{player_name} is in check."
  end

  def thanks_for_playing
    puts 'Thank you for playing!'
  end

  def ambiguous_choice
    puts 'Multiple pieces can move here. Please write the rank and file of your choice in algebraic notation. (i.e. d6)'
    gets.chomp
  end

  def check_mate(loser_name:, winner_name:)
    puts "#{loser_name} is in checkmate. #{winner_name} wins!"
  end

  def stale_mate
    puts "The game has reached a stalemate. It's a draw."
  end
end
