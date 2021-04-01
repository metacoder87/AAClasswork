


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

    attr_reader :considered, :start_pos, :root_node, :end_node

    def initialize(pos)
        @start_pos = pos
        @considered = [pos]
        @root_node = PolyTreeNode.new(pos)
        build_move_tree
    end

    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos).select { |move| !@considered.include?(move) }
        moves.each { |move| @considered << move }
        moves
    end

    def build_move_tree
        queue = [@root_node]
        until queue.empty?
        move = queue.shift
            next_moves = new_move_positions(move.value)
            next_moves.each do |next_move| 
                new_node = PolyTreeNode.new(next_move)
                new_node.parent = move
                queue << new_node
            end
        end
    end

    def find_path(end_pos)
        @end_node = @root_node.bfs(end_pos)
        trace_path_back
    end

    def trace_path_back
        current_node = @end_node
        path = []
        if current_node
            path.unshift(current_node.value)
            current_node = current_node.parent
        else return path
        end
    end

end