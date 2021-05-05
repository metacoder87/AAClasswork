


class Knight < Piece
    include Stepable

    def symbol
        return :BN if @position.first == 0
        return :BK
    end

protected

    def move_difs

    end

end