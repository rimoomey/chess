require 'bundler/setup'
Bundler.require(:default, :development)

require 'rspec'
require 'rubocop'
require 'rest-client'
require 'pry'

require_relative '../lib/modules/capture'
require_relative '../lib/modules/check'
require_relative '../lib/modules/check_mate'
require_relative '../lib/modules/game_state'
require_relative '../lib/modules/movement'
require_relative '../lib/modules/notation_parsing'
require_relative '../lib/modules/stale_mate'
require_relative '../lib/modules/ui'

require_relative '../lib/pieces/bishop'
require_relative '../lib/pieces/king'
require_relative '../lib/pieces/knight'
require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/piece'
require_relative '../lib/pieces/queen'
require_relative '../lib/pieces/rook'

require_relative '../lib/board'
require_relative '../lib/chess_player'
require_relative '../lib/chess'
require_relative '../lib/piece_factory'
