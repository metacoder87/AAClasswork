require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer

  def move(game, mark)
    moves = []
    node = TicTacToeNode.new(game.board, mark)
    if node.children.none? { |child| child.winning_node?(mark) }
        return node.children.select { |child| !child.losing_node?(mark) ? child.prev_move_pos : next }.first
    else node.children.each { |child| moves << child.prev_move_pos if child.winning_node?(mark) }
    end
    moves
  end
  
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
