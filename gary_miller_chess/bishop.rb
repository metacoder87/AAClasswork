require_relative 'slideable'


class Bishop < Piece
    include Slideable

    def initialize(board, position, color = nil)
        super
        @color = color || set_color
    end

    def symbol
        return "\u265d"+"B"
    end

private

    def move_dirs
        diaganol_dirs
    end

end