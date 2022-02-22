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

  # taken from heraldry, meaning a diagonal going from top left to bottom right
  def check_diagonal_dexter
    positions = []
    3.times do |i|
      positions << self[[i, i]]
    end
    return true if positions.all? { |ele| ele == :X } || positions.all? { |ele| ele == :O }

    false
  end

  # taken from heraldry, meaning a diagonal going from bottom left to top right
  def check_diagonal_sinister
    positions = []
    offset = @rows.length - 1
    3.times do |i|
      positions << self[[offset, i]]
      offset -= 1
    end
    return true if positions.all? { |ele| ele == :X } || positions.all? { |ele| ele == :O }

    false
  end

  def check_diagonals
    check_diagonal_dexter || check_diagonal_sinister
  end
  # end of winner? helper methods

  # checks if all spaces are filled and there is no winner
  def full?
    @rows.flatten.none? { |ele| ele == '_' }
  end
end
