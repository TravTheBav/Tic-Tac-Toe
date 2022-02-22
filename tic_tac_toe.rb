require_relative 'game'
require_relative 'board'

board = Board.new
game = Game.new(board)
game.play
