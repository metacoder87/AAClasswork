require_relative 'slideable'


class Rook < Piece
    include Slideable

    def initialize(board, position, color = nil)
        super
        @color = color || set_color
    end

    def set_color
        x, y = @position
        return "black" if x == 0 || x == 1
        return "white" if x == 6 || x == 7
    end

    def symbol
        x, y = @position
        return :♜R if x == 0
        return :♖R
    end

#private

    def move_dirs
        horizontal_dirs
    end

end