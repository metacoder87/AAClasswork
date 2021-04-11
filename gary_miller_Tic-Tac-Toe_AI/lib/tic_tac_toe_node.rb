require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos, :prev_mark

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    next_mover_mark == :x ? @prev_mark = :o : @prev_mark = :x
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return board.won? && @board.winner != evaluator if @board.over?
    if @next_mover_mark == evaluator
      children.all? { |child| child.losing_node?(evaluator) } 
    else
      children.any? { |child| child.losing_node?(evaluator) }  
    end
  end

  def winning_node?(evaluator)
    return true if @board.over? && @board.winner == evaluator
    return false if @board.over? && @board.winner.nil?
    if evaluator == @prev_mark
      children.all? { |child| child.winning_node?(evaluator) }
    elsif evaluator == @next_mover_mark
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
