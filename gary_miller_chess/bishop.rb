require_relative 'slideable'


class Bishop < Piece
    include Slideable

    def initialize(board, position)
        super
        @color = symbol
    end

    def symbol
        x, y = @position
        return :♝B if x == 0
        return :♗B
    end

private

    def move_dirs
        
    end

end