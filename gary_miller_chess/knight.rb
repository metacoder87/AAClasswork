require_relative 'stepable'


class Knight < Piece
    include Stepable

    def initialize(board, position, color = nil)
        super
        @color = color || set_color
    end

    def symbol
        return "\u265e"+"k"
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