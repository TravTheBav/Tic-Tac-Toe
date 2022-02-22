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
          print "#{box}|"
        end
      end
    end
  end

  def winner?
    check_rows || check_cols || check_diagonals
  end

  # helper methods for the winner? method
  def check_rows
    @rows.each do |row|
      return true if row.all? { |ele| ele == :X }
      return true if row.all? { |ele| ele == :O }
    end
    false
  end

  def check_cols
    @rows.transpose.each do |col|
      return true if col.all? { |ele| ele == :X }
      return true if col.all? { |ele| ele == :O }
    end
    false
  end

  def check_diagonals

  end

end