


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

    def initialize(pos)
        @considered = [pos]
        @starting_position = pos
        # build_move_tree
    end

    def new_move_positions(pos)
        self.valid_moves !include?(@considered)
    end

    def build_move_tree(pos)
        root_node = @starting_position
        queue = [pos]
        next_moves = new_move_positions(pos)
        until queue.empty?
        next_node = queue.unshift
        queue << next_moves.unshift
        bfs(next_node)
        end
    end

end