require_relative 'slideable'


class Rook < Piece
    include Slideable

    def initialize(board, position)
        super
        @color = symbol
    end

    def symbol
        x, y = @position
        return :BR if x == 0
        return :WR
    end

private

    def move_dirs
        
    end

end