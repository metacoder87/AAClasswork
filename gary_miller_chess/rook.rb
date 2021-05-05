


class Rook < Piece
    include Slideable

    def symbol
        return :BR if @position.first == 0
        return :WR
    end

private

    def move_dirs
        
    end

end