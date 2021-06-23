require 'byebug'
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
            grow_unblocked_moves_in_dir(x, y).each do |spot|
                all_moves << spot
            end
        end
        return all_moves
    end

# private

    HORIZONTAL_DIRS = []

    DIAGANOL_DIRS = []

    def move_dirs
        both = []
        if self.is_a?(Bishop)
            return diaganol_dirs 
        elsif self.is_a?(Rook)
            return horizontal_dirs 
        else 
            both << diaganol_dirs
            both << horizontal_dirs
            return both
        end
    end

    def opposite_color(colour)
        return true if @color == "white" && colour == "black"
        return true if @color == "black" && colour == "white"
        return false
    end

    def grow_unblocked_moves_in_dir(dx, dy)
        clear_path = []
        x, y = @position
        #debugger
        until !(0..7).include?(x) || !(0..7).include?(y)
            x += dx
            y += dy
            if (0..7).include?(x) && (0..7).include?(y) && board[x][y].symbol == :__
                clear_path << [x,y]
            elsif (0..7).include?(x) && (0..7).include?(y) && board[x][y].color == opposite_color(self.color)
                clear_path << [x,y]
                break
            elsif (0..7).include?(x) && (0..7).include?(y) && board[x][y].color == self.color
        end
        
        return clear_path
    end

end

# board.move_piece([1,0],[2,1])
# board[0,0].grow_unblocked_moves_in_dir(1,0)