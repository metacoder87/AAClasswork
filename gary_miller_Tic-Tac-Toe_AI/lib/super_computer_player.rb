require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer

    # Finds the best possible move each time to always WIN or at least prevent
    # the other player from winning.
  def move(game, mark)
    # Generates all possible move nodes
    node = TicTacToeNode.new(game.board, mark)
    moves = node.children
    # Finds the winning node if it exists.
    node = moves.find { |child| child.winning_node?(mark) }
    return node.prev_move_pos if node
    # Otherwise it finds the node that won't lose.
    node = moves.find { |child| !child.losing_node?(mark) }
    return node.prev_move_pos if node
    # Otherwise it admits defeat.
    raise "No winning path found. You will lose."
  end

end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
