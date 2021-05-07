require_relative 'slideable'


class Bishop < Piece
    include Slideable

    def initialize(board, position)
        super
        @color = symbol
    end

    def symbol
        x, y = @position
        return :BB if x == 0
        return :WB
    end

private

    def move_dirs
        
    end

end