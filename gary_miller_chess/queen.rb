


class Queen < Piece
    include Slideable

    def symbol
        return :Q
    end

private

    def move_dirs
        return "both"
    end

end