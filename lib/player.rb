class Player
  attr_reader :symbol, :name

  def initialize(symbol)
    @symbol = symbol
    @name = gets.chomp
  end

  def move
    puts 'Enter a board position (e.g. 0,1): '
    gets.chomp
  end
end
