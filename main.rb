require 'matrix'

class ChessBoard
  attr_reader :size
  def initialize(n: 8, m: n, v: Vector[2,1])
    @data = Matrix.zero(n, m)
    @moves = compute_knight_moves(v)
    @size = n * m
  end

  # get the content of a specific board cell
  # We define the method [], which means we can do
  # board[pos] and get the cell value
  def [](pos)   
    # we will call this with a position
    # but matrix expects two values, so we decompose it
    @data[*pos]
  end
  
  # set one board cell
  # b[pos] = 3
  def []=(pos, value)
    @data[*pos] = value
  end

  # where can we move to?
  def possible_moves(pos)
    @moves.map { |p| pos + p }.select { |p| valid?(p) }
  end

  # is the given position a valid move?
  def valid?(pos)
    pos[0] >= 0 && pos[1] >= 0 && @data[*pos] == 0 
  end
  
  # give a nice string representation of a board
  def to_s(cell_width=3)
    @data.row_vectors.map { |v|   # '|' ?
      v.to_a.map { |x| x.to_s.rjust(cell_width) }.join 
    }.join("\n")
  end

  # The following part is completely overengineered ;-)
  # We should simply have given the possible moves ;-)
  Rot90 = Matrix[[0,-1],[1,0]]
  Flip  = Matrix[[0,1],[1,0]]
  def compute_knight_moves(v)
    # v is a vector with two components
    vt = Flip * v
    (0..3).map { |i| Rot90**i * v } +
        (0..3).map { |i| Rot90**i * vt }  
  end
end # class 

class Runner
  def initialize(board: ChessBoard.new)
    @board = board
  end
  def run(pos: Vector[0,0], k: 1)
    # First we tell the chessboard that we are here:
    @board[pos] = k

    return @board if k >= @board.size # found it!
    moves = @board.possible_moves(pos)
    moves.each do |p| 
      if result = run(pos: p, k: k + 1)
        return result
      end
    end
    @board[pos] = 0
    return false
  end
end

puts Runner.new(board: ChessBoard.new(n: 6)).run