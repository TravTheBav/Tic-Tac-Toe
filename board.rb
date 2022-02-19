class Board
  attr_accessor :rows
    
  def initialize
    @rows = Array.new(3) { Array.new(3, '_') }
  end

  # use board[pos] where pos is [row, col] to easily access board positions
  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  # sets board[pos] to a given symbol
  def []=(pos, symbol)
    row, col = pos
    @rows[row][col] = symbol
  end
  
  def render
    @rows.each do |row|
      row.each_with_index do |box, idx|
        case idx
        when 2
          print box.to_s
          puts
        else
          print box.to_s + '|'
        end
      end
    end
  end

end