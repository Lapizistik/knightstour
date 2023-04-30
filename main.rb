require 'matrix'

class ChessBoard
  def initialize(n=8)
    @board = Matrix.zero(8)
  end

  # get the content of a specific board cell
  # We define the method [], which means we can do
  # board[pos] and get the cell value
  def [](pos)   
    # we will call this with a position
    # but matrix expects two values, so we decompose it
    @board[*pos]
  end
  
  # set one board cell
  # b[pos] = 3
  def []=(pos, value)
    @board[*pos] = value
  end
  
  # give a nice string representation of a board
  def to_s(cell_width=3)
    @board.row_vectors.map { |v|   # '|' ?
      v.to_a.map { |x| x.to_s.rjust(cell_width) }.join 
    }.join("\n")
  end
end # class 

