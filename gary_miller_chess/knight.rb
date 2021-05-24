require_relative 'stepable'


class Knight < Piece
    include Stepable

    def initialize(board, position)
        super
        @color = set_color
    end

    def set_color
        x, y = @position
        return "black" if x == 0 || x == 1
        return "white" if x == 6 || x == 7
    end

    def symbol
        x, y = @position
        return :♞k if x == 0
        return :♘k
    end

protected

    def move_difs
        valid_moves = []
        knight_moves = [[1,2],[2,1],[-1,2],[-2,1],[1,-2],[2,-1],[-1,-2],[-2,-1]]
        knight_moves.each do |move|
            x = pos[0] + move[0]
            y = pos[1] + move[1] 
            valid_moves << [x,y] if (0..7).include?(x) && (0..7).include?(y)
        end
        valid_moves
    end

end