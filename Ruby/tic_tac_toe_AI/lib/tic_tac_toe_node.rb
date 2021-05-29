require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :prev_move_pos, :board, :next_mover_mark
  MARKS = [:x, :o]
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over? 
      winner = @board.winner
      if winner && winner != evaluator
        return true
      else
        return false
      end
    end
    if evaluator == @next_mover_mark
      return true if children.all?{|c| c.losing_node?(evaluator)}
    else
      return true if children.any?{|c| c.losing_node?(evaluator)}
    end
    false
  end

  def winning_node?(evaluator)
    if @board.over? 
      return @board.winner == evaluator
    end
    if evaluator == @next_mover_mark
      return true if children.any?{|c| c.winning_node?(evaluator)}
    else
      return true if children.all?{|c| c.winning_node?(evaluator)}
    end
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    ret = []
    for i in 0..2
      for j in 0..2
        pos = [j,i]
        if @board.empty?(pos)
          tmp = @board.dup
          tmp[pos] = @next_mover_mark
          ret << TicTacToeNode.new(tmp, MARKS[(MARKS.index(@next_mover_mark) + 1) % 2], pos)
        end
      end
    end
    ret
  end
end
