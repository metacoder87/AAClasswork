

module Slideable

    def horizontal_dirs
        [[0,1], [0,-1], [1,0], [-1,0]].each { |dir| HORIZONTAL_DIRS << dir unless HORIZONTAL_DIRS.include?(dir) }
        return HORIZONTAL_DIRS
    end

    def diaganol_dirs
        [[1,1], [1,-1], [-1,-1], [-1,1]].each { |dir| DIAGANOL_DIRS << dir unless DIAGANOL_DIRS.include?(dir) }
        return DIAGANOL_DIRS
    end

    def moves
        all_moves = []
        move_dirs.each do |move|
            x, y = move
            all_moves << grow_unblocked_moves_in_dir(x, y)
        end
        return all_moves
    end

private

    HORIZONTAL_DIRS = []

    DIAGANOL_DIRS = []

    def move_dirs
        both = []
        both << diaganol_dirs && horizontal_dirs
        if self.is_a?(Bishop)
            return diaganol_dirs 
        elsif self.is_a?(Rook)
            return horizontal_dirs 
        else return both
        end
    end

    def grow_unblocked_moves_in_dir(dx, dy)
        clear_path = []
        x, y = @position
        until x == 7 || y == 7 || x == 0 || y == 0
            x += dx
            y += dy
            if @board.rows[x][y].empty?
                clear_path << [x, y]
            end
        end
        return clear_path
    end

end