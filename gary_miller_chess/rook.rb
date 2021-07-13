require_relative 'slideable'


class Rook < Piece
    include Slideable

    def initialize(board, position, color = nil)
        super
        @color = color || set_color
    end

    def symbol
        x, y = @position
        return "\u265c"+"R"
    end

private

    def move_dirs
        horizontal_dirs
    end

end