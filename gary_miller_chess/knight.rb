require_relative 'stepable'


class Knight < Piece
    include Stepable

    def initialize(board, position)
        super
        @color = symbol
    end

    def symbol
        x, y = @position
        return :BN if x == 0
        return :WN
    end

protected

    def move_difs

    end

end