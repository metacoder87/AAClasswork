require_relative 'stepable'


class King < Piece
    include Stepable

    def symbol
        x, y = @position
        return :♚K if x == 0
        return :♔K
    end

protected

    def move_difs

    end

end