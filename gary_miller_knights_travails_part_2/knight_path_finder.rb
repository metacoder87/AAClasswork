            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/AAClasswork


require_relative '00_tree_node'

class KnightPathFinder

    # Finds the various moves a knight may make in chess from a given position

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

    # Saves the starting position creates a box to store all considered moves
    # Creates the root node of a Poly Tree and launches a method to build a
    # Tree of moves

    def initialize(pos)
        @start_pos = pos
        @considered = [pos]
        @root_node = PolyTreeNode.new(pos)
        build_move_tree
    end

    # Finds all potential immediate moves from a given position

    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos).select { |move| !@considered.include?(move) }
        moves.each { |move| @considered << move }
        moves
    end

    # Builds the Poly Tree of moves

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

    # Finds a path of moves from the starting position to a given end position
    # By searching the Poly Tree with a Breadth First Search and launching a 
    # Helper method to seperate the node values

    def find_path(end_pos)
        @end_node = @root_node.bfs(end_pos)
        trace_path_back
    end

    # This is the helper method the sorts out the node values from the path

    def trace_path_back
        current_node = @end_node
        path = []
        until current_node.nil?
            path << current_node.value
            current_node = current_node.parent
        end
        path.reverse
    end

end



 # test cases

kpf = KnightPathFinder.new([0, 0])
kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]