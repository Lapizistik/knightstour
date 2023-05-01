# Knight's Tour #

Some simple implementation of [knight's tour](https://en.wikipedia.org/wiki/Knight%27s_tour) algorithm(s).

The code was created as I was asked on [Discord](https://discord.gg/ruby-518658712081268738) on how to do this from an interested beginner with little experience in Ruby.

## Brute Force (`first_try.rb`) ##

`first_try.rb` has a purely imperative brute force DFS. 

It deliberately only uses few Ruby features and has lots of explanatory comments I would not have in production code. I just leave it as it is.

## OO with Heuristics (`main.rb`) ##

`main.rb` is a slightly more OO approach which uses the Warnsdorff's heuristics.

For fun I decided to use a matrix for the chess board and vectors for positions and moves (as I can just add them).

The main idea is to show how the algorithm (`Runner#run`) can get simpler by providing the board with helpful features.

`main_test.rb` has some tests of board features (but does by far not cover everything).

## other ##

The `Gemfile` is not really needed, but as the code was created on [replit](https://replit.com/) (to show someone else how one could do this) it was there anyway.