require_relative 'slideable'


class Rook < Piece
    include Slideable

    def symbol
        x, y = @position
        return :♜R if x == 0
        return :♖R
    end

private

    def move_dirs
        
    end

end