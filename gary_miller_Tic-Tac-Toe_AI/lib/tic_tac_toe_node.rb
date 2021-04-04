require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    if prev_move_pos
      @prev_move_pos = prev_move_pos
    end
  end

  def losing_node?(evaluator)
    if @board.over?
    end
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    day_care = []
      @board.rows.each_with_index do |row, idx| 
        row.each_with_index do |child, i|
          child_node = []
          grid = @board.dup 
          child_node << grid[idx, i] = next_mover_mark
          child_node << @prev_move_pos = [idx, i]
          day_care << child_node
        end
      end
      p day_care
  end

end
