require_relative 'game.rb'
require_relative 'board.rb'

board = Board.new
game = Game.new(board)
game.play
