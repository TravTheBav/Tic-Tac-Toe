require_relative 'board.rb'
require_relative 'player.rb'

class Game
  attr_accessor :board, :players

  def initialize(board)
    @board = board
    @players = []
    @current_player
  end

  def play
    puts "Let's play Tic Tac Toe!"
    setup_players
    start_turn until board.winner? || board.full?
  end

  def setup_players
    puts 'Player 1, enter your name: '
    p1 = Player.new(:X)
    puts 'Player 2, enter your name: '
    p2 = Player.new(:O)
    players.push(p1, p2)
  end

  def start_turn
    system('clear')
    board.render
    @current_player = @players[0]
    position = @current_player.move
    until @board.valid_pos?(position) && @board.empty_pos?(position)
      position = @current_player.move
    end
    position = [position[0].to_i, position[2].to_i]
    board.update_pos(position, @current_player.symbol)
    toggle_next_player
  end

  def toggle_next_player
    @players.reverse!
  end
end
