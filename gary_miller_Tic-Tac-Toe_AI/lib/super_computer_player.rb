require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer

  def move(game, mark)
    moves = []
    node = TicTacToeNode.new(game.board, mark)
    tree = node.children
    tree.each do |child|
      moves << child.prev_move_pos if child.winning_node?(mark)
    end
    return moves if !moves.empty?

    raise "No winning moves, I quit"
  end
  
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
