


class King < Piece
    include Stepable

    def symbol
        return :BK if @position.first == 0
        return :WK
    end

protected

    def move_difs

    end

end