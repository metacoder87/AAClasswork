


class KnightPathFinder

    def self.valid_moves(pos)
        self.parent
    end

    def initialize(pos)
        @considered = [pos]
        @starting_position = pos
        build_move_tree
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