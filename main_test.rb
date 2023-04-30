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

  def test_valid_moves
    board = ChessBoard.new 
    
  end
end
