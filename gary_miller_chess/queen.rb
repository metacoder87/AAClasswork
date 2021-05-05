


class Queen < Piece
    include Slideable

    def symbol
        return :BQ if @position.first == 0
        return :WQ
    end

private

    def move_dirs
        
    end

end