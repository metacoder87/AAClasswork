


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

    end

end