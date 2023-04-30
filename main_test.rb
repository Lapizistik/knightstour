require "minitest/autorun"
require_relative "main"

# the code in this test class is more sophisticated, I may not explain everything

class TestChessBoard < Minitest::Test 

  # first we test if the board works as expected with reading and writing values
  def test_board_read_write
    board = ChessBoard.new
    v = Vector[3,4]
    # we expect all fields to be cero
    assert_equal board[v], 0
    # now we set something:
    board[v] = 5
    # and expect it to be set
    assert_equal board[v], 5
  end

  # does our visualization work as expected?
  def test_board_display
    board = ChessBoard.new(2)
    board[Vector[0,0]] = 1
    board[Vector[0,1]] = 2
    board[Vector[1,0]] = 3
    assert_equal board.to_s, "  1  2\n  3  0"
  end

  def test_knight_moves
    assert_equal [Vector[-2, -1], Vector[-2, 1], 
                  Vector[-1, -2], Vector[-1, 2], 
                  Vector[1, -2], Vector[1, 2], 
                  Vector[2, -1], Vector[2, 1]],
                 ChessBoard.new.compute_knight_moves(Vector[2,1]).sort_by(&:to_a)
  end
  
  def test_valid_moves
    board = ChessBoard.new 
    assert board.valid?(Vector[1,1])
    refute board.valid?(Vector[-1,1])
    refute board.valid?(Vector[1,8])
    assert_equal [Vector[1,2], Vector[2,1]], 
                 board.possible_moves(Vector[0,0]).sort_by(&:to_a)
    assert_equal [Vector[2, 3], Vector[2, 5], Vector[3, 2], Vector[3, 6], 
                  Vector[5, 2], Vector[5, 6], Vector[6, 3], Vector[6, 5]],
                 board.possible_moves(Vector[4,4]).sort_by(&:to_a)
    assert_equal [Vector[5,6], Vector[6,5]], 
                 board.possible_moves(Vector[7,7]).sort_by(&:to_a)
    assert_equal [Vector[1,5], Vector[2,6]], 
                 board.possible_moves(Vector[0,7]).sort_by(&:to_a)

  end
end
