class Game
  def initialize(board)
    @board = board
    @players = []
  end  
  
  def play
    puts "Let's play Tic Tac Toe!"
    setup_players
  end  
  
  def setup_players
    puts "Player 1, enter your name: "
    p1_name = gets.chomp
    puts "Player 2, enter your name: "
    p2_name = gets.chomp
    p1 = Player.new(p1_name, :X)
    p2 = Player.new(p2_name, :O)
    @players.push(p1, p2)
  end
end