require_relative 'slideable'


class Queen < Piece
    include Slideable

    def initialize(board, position)
        super
        @color = symbol
    end

    def symbol
        x, y = @position
        return :BQ if x == 0
        return :WQ
    end

private

    def move_dirs
        
    end

end