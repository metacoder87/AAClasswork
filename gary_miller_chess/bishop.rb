


class Bishop < Piece
    include Slideable

    def symbol
        return :B
    end

private

    def move_dirs
        return "diaganol"
    end

end