


class Bishop < Piece
    include Slideable

    def symbol
        return :BB if @position.first == 0
        return :WB
    end

private

    def move_dirs
        
    end

end