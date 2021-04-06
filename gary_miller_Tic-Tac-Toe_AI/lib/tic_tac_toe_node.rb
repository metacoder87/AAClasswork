require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    if next_mover_mark == :x
      @prev_mark = :o
    else @prev_mark = :x
    end
    if prev_move_pos
      @prev_move_pos = prev_move_pos
    end
  end

  def losing_node?(evaluator)
    return true if @board.over? && @board.winner != evaluator
    if @next_mover_mark != evaluator
      return true if children.any? { |child| child.losing_node?(evaluator) }
    elsif @next_mover_mark == evaluator
      return true if children.all? { |child| child.losing_node?(evaluator) } && children.count > 1
    end
    false
  end

  def winning_node?(evaluator)
    return true if @board.over? && @board.winner == evaluator
    if @next_mover_mark == evaluator
      return true if children.any? { |child| child.winning_node?(evaluator) }
    end
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    day_care = []
      @board.rows.each_with_index do |row, idx| 
        row.each_with_index do |child, i|
          if @board.empty?([idx, i])
            grid = @board.dup
            grid.[]=([idx, i], next_mover_mark)
            day_care << TicTacToeNode.new(grid, @prev_mark, prev_move_pos = [idx, i])
          else next
          end
        end
      end
      day_care
  end

end
