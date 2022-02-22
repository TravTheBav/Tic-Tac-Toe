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
    until board.winner? || board.full?
      system('clear')
      board.render
      @current_player = @players[0]
      position = @current_player.get_move
      board.update(position, @current_player.symbol)
      toggle_next_player
    end
  end  
  
  def setup_players
    puts "Player 1, enter your name: "
    p1 = Player.new(:X)
    puts "Player 2, enter your name: "
    p2 = Player.new(:O)
    players.push(p1, p2)
  end

  def toggle_next_player
    @players.reverse!
  end
end