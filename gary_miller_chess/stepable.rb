require 'byebug'
module Stepable

    def moves
        #debugger
        all_moves = []
        move_diffs.each do |move|
            x, y = @position
            a, g = move
                x += a 
                y += g
                if x > 7 || x < 0 || y < 0 || y > 7
                    next
                elsif @board[x][y].color == @color
                    next
                elsif (0..7).include?(x) && (0..7).include?(y)
                    all_moves << [x,y]
                end 
        end
        return all_moves
    end

    def opposite_color
        return "black" if @color == "white" 
        return "white" if @color == "black"
    end

#private

    SINGLE_STEPS = [[0,1], [0,-1], [1,0], [-1,0], [1,1], [1,-1], [-1,-1], [-1,1]]

    LONG_STEPS = [[1,-2], [2,-1],  [2,1],  [1,2], [-1,-2], [-2,-1], [-2,1], [-1,2]]

    def move_diffs
        return LONG_STEPS if self.is_a?(Knight)
        return SINGLE_STEPS if self.is_a?(King)
    end

end