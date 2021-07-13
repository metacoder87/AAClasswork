require_relative 'slideable'


class Queen < Piece
    include Slideable

    def initialize(board, position, color = nil)
        super
        @color = color || set_color
    end

    def symbol
        return "\u265b"+"Q"
    end

private

    def move_dirs
        both = diaganol_dirs + horizontal_dirs
        return both
    end

end