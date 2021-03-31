


require 'byebug'
require_relative '00_tree_node'

class KnightPathFinder

    def self.valid_moves(pos)
        valid_moves = []
        knight_moves = [[1,2],[2,1],[-1,2],[-2,1],[1,-2],[2,-1],[-1,-2],[-2,-1]]
        knight_moves.each do |move|
            x = pos[0] + move[0]
            y = pos[1] + move[1] 
            valid_moves << [x,y] if (0..7).include?(x) && (0..7).include?(y)
        end
        valid_moves
    end

    attr_reader :considered, :start, :root

    def initialize(pos)
        @considered = [pos]
        @start = pos
        @root = PolyTreeNode.new(@start)
        build_move_tree
    end

    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos).select { |move| !@considered.include?(move) }
        moves.each { |move| @considered << move }
        moves
    end

    def build_move_tree
        tree = [@root]
        queue = [@root]
        # debugger
        until queue.empty?
        move = queue.shift
            next_moves = new_move_positions(move.value)
            next_moves.each do |next_move| 
                new_node = PolyTreeNode.new(next_move)
                new_node.parent = move
                tree << new_node
                queue << next_move
            end
        end
        tree
    end

end