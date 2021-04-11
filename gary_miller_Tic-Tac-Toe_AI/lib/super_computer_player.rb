require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer

  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    @moves = node.children

    node = winning_node(mark)
    return node.prev_move_pos if node

    node = not_losing_node(mark)
    return node.prev_move_pos if node

    raise "No winning path found. You will lose."
  end

  def winning_node(mark)
    @moves.find { |child| child.winning_node?(mark) }
  end

  def not_losing_node(mark)
    @moves.find { |child| !child.losing_node?(mark) }
  end

end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
