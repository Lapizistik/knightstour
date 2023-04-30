# so let's go
# First thing you are doing is creating the board

# Lets write a method that does this.
def create_board(n = 8)
  #  (0...n).map {	Array.new(n,0) }
  Array.new(n) { Array.new(n, 0) }
end

# CONSTANT: start with an uppercase letter for constants
MOVES = [[-2, -1], [-2, 1],
         [-1, -2], [-1, 2],
         [1, -2], [1, 2],
         [2, -1], [2, 1]].freeze

def run_knight(xo, yo, board, k = 1, n = board.size) # ok agree
  # now we set us at this position
  board[yo][xo] = k

  if k >= n * n # we found a solution
    puts board.map { |a| a.map { |i| '%3i' % i }.join }.join("\n")
    exit
  end
  # so now we go through all the possible moves and see if a move is possible
  MOVES.each do |dx, dy|
    # but not all positions are allowd
    # so we have to check if the position is allowd at all
    x = xo + dx
    y = yo + dy
    next unless (0...n).include?(x) && (0...n).include?(y)

    # we have a position that is _on_ the board but we do not know
    # if the position is available
    if board[y][x] == 0
      # so here we call our method recursively
      run_knight(x, y, board, k + 1, n)
    end
  end
  # and on the way back we remove ourselves again
  board[yo][xo] = 0
end

# here we call this method with our board
# by calling create_board
board = create_board(5) # min board size is 5x5!
run_knight(1, 1, board)

# ok DFS without strategy takes too long

## Ha, it works. Without heuristics it takes some time but
# after some minutes we get a result with 8×8.
# *** i am back ***
# for implementing a heuristics I would first rewrite the code a little bit.
# maybe I find some time the next days.
# oh yes... i see it only now... at the bottom in console
# opps.. it takes some time.. ;-)
# yes! it works.
# you have impressed me!
# thank you :-)
# And this solution is rather close to your original approach
# Fully imperative style, no objects.
# :-D
