module Stepable

    def moves
        all_moves = []
        move_diffs.each do |move|
            x, y = @position
            x1, y1 = move
                x += x1 && y += y1
                all_moves << [x,y] if (0..7).include?(x) && (0..7).include?(y)
        end
        return all_moves
    end

private

    SINGLE_STEPS = [[0,1], [0,-1], [1,0], [-1,0], [1,1], [1,-1], [-1,-1], [-1,1]]

    LONG_STEPS = [[1,-2], [2,-1],  [2,1],  [1,2], [-1,-2] [-2,-1], [-2,1], [-1,2]]

    def move_diffs
        return LONG_STEPS if self.is_a?(Knight)
        return SINGLE_STEPS if self.is_a?(King)
    end

end