class Player
  attr_reader :symbol, :name

  def initialize(symbol)
    @symbol = symbol
    @name = gets.chomp
  end
end
