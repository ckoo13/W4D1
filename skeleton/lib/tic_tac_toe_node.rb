require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    #base case
      #evaluator is a mark signifying our turn
    if board.over?
      return board.won? && board.winner != evaluator
    end

    #this signifies the players turn
    if evaluator == self.next_mover_mark
      self.children.all? { |node| node.losing_node?(evaluator)}
    else
    #this signifies the opponents turn
      evaluator != self.next_mover_mark
      self.children.any? {|node| node.losing_node?(evaluator)}
    end

  end

  def winning_node?(evaluator)
    #base case
      #if the game is over and we have won
        #evaluator is a mark signalling the mark on our turn
    if board.over?
      return board.winner == evaluator
    end
    
    #signifies our turn
    if evaluator == self.next_mover_mark
      self.children.any? { |node| node.winning_node?(evaluator)}
    else
      #signifies opponents turn
      self.children.all? { |node| node.winning_node?(evaluator)}
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    #returns nodes representing all the potential game states one move after the current node
    #iterate through all positions that are empty? on board object
      #each empty position ->
        #create a node by duping the board ->
          #put a next_mover_mark in that position (alternate after)
            #set prev_move_pos to the position you just marked

    #methods we can use
      #Board.dup
      #Board.empty(pos)
      #TicTacToe.turn
    children = []
    
    #iterating through board
    (0...3).each do |row|
      (0...3).each do |col|
        pos = [row,col]
      
        if @board.empty?(pos)
          new_board = @board.dup
          next_mover_mark = (self.next_mover_mark == :x ? :o : :x)
          child = TicTacToeNode.new(new_board, next_mover_mark, pos)
          child.board[pos] = self.next_mover_mark
          
          children << child
        end
      end
    end

    children
  end


end
