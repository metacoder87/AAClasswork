require_relative 'stepable'


class King < Piece
    include Stepable

    def initialize(board, position, color = nil)
        super
        @color = color || set_color
    end
    
    def symbol
        return "\u265a"+"K"
    end

protected

    def move_difs

    end

end