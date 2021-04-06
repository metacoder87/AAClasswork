require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer

  def move(game, mark)
    moves = []
    node = TicTacToeNode.new(game.board, mark)
    node.children.each do |child|
      moves << child.prev_move_pos if child.winning_node?(mark)
    end
    return moves.first if moves.count == 1
    return moves
  end
  
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
