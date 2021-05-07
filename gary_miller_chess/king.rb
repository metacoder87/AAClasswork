require_relative 'stepable'


class King < Piece
    include Stepable

    def initialize(board, position)
        super
        @color = symbol
    end

    def symbol
        x, y = @position
        return :BK if x == 0
        return :WK
    end

protected

    def move_difs

    end

end