require_relative 'stepable'


class King < Piece
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
        return :♚K if x == 0
        return :♔K
    end

protected

    def move_difs

    end

end