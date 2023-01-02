# frozen_string_literal: true

module UI
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
end
