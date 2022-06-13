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
    if evaluator == next_mover_mark #we are checking if the winner is the opponent
      if board.over? && board.winner == evaluator
        return true
      end
    end

    if evaluator !- next_mover_mark
      if board.over? && board.winner.nil?
        return false
      end
    end

    #inductive step (for opponent)
    if evaluator == next_mover_mark
      self.children.each do |node|
        losing_node?(node.next_mover_mark)
      end
    end

  end

  def winning_node?(evaluator)

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
          child = TicTacToeNode.new(@board.dup, :o, pos)
          child.board[pos] = @next_mover_mark
          children << child
        end
      end
    end

    children
  end


end
