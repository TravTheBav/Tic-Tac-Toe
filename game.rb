require_relative 'board'
require_relative 'player'

class Game
  attr_accessor :board, :players

  def initialize(board)
    @board = board
    @players = []
  end

  def play
    puts "Let's play Tic Tac Toe!"
    setup_players
    start_turn until board.winner? || board.full?
    if board.winner?
      update_terminal
      puts "#{@winner.name} wins!"
    end
  end

  def setup_players
    puts 'Player 1, enter your name: '
    p1 = Player.new(:X)
    puts 'Player 2, enter your name: '
    p2 = Player.new(:O)
    players.push(p1, p2)
  end

  def start_turn
    update_terminal
    @current_player = @players[0]
    position = prompt_player
    board.update_pos(position, @current_player.symbol)

    @winner = @current_player if board.winner?
    toggle_next_player
  end

  def update_terminal
    system('clear')
    board.render
  end

  # prompts player for input and returns the position array
  def prompt_player
    position = @current_player.move
    until @board.valid_pos?(position) && @board.empty_pos?(position)
      puts 'Invalid position entered: must be entered correctly and not an occupied space'
      position = @current_player.move
    end
    @board.convert_pos_string(position)
  end

  def toggle_next_player
    @players.reverse!
  end
end
