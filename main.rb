require 'matrix'

class ChessBoard
  attr_reader :size
  def initialize(n: 8, m: n, v: Vector[2, 1])
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

  def adjacent?(pos, value=1)
    @moves.map { |p| pos + p }.any? { |p| p[0] >= 0 && p[1] >= 0 && @data[*p] == value }
  end

  # is the given position a valid move?
  def valid?(pos)
    pos[0] >= 0 && pos[1] >= 0 && @data[*pos] == 0
  end

  # give a nice string representation of a board
  def to_s(cell_width = 3)
    @data.row_vectors.map do |v| # '|' ?
      v.to_a.map { |x| x.to_s.rjust(cell_width) }.join
    end.join("\n")
  end

  # The following part is completely overengineered ;-)
  # We should simply have given the possible moves ;-)
  Rot90 = Matrix[[0, -1], [1, 0]]
  Flip  = Matrix[[0, 1], [1, 0]]
  def compute_knight_moves(v)
    # v is a vector with two components
    vt = Flip * v
    # we have them counter clockwise
    (0..3).flat_map { |i| r = Rot90**i and [r * v, r * vt] }
  end
end # class

class Runner
  # we can run on arbitrary chess boards and can
  # also try to create a roundtrip
  def initialize(board: ChessBoard.new, roundtrip: false)
    @board = board
    @roundtrip = roundtrip
  end

  def run(pos: Vector[0, 0], k: 1, moves: @board.possible_moves(pos))
    # First we tell the chessboard that we are here:
    @board[pos] = k

    return @board if (k >= @board.size) &&
                     (!@roundtrip || @board.adjacent?(pos, 1))

    # so lets decide the next step
    moves.map { |p| [p, @board.possible_moves(p)] }.sort_by { |_p, ms| ms.length }
         .each do |p, ms|
      if result = run(pos: p, k: k + 1, moves: ms)
        return result
      end
    end
    @board[pos] = 0
    false
  end
end

# puts Runner.new(board: ChessBoard.new(n: 8)).run
puts Runner.new(roundtrip: true).run
