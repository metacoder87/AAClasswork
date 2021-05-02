


class Rook < Piece
    include Slideable

    def symbol
        return :R
    end

private

    def move_dirs
        return "vert/hor"
    end

end