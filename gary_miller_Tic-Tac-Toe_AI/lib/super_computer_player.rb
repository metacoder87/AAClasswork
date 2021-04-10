require_relative 'tic_tac_toe_node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer

  def move(game, mark)
    @node = TicTacToeNode.new(game.board, mark)
    not_losing_node(mark)
  end

  def winning_node(mark)
    @node.children.select { |child| child.winning_node?(mark) }.first.prev_move_pos 
  end

  def not_losing_node(mark)
    @node.children.select { |child| child.losing_node?(child.prev_mark) ? next : child }
  end

end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
