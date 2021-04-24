class Piece

    attr_accessor :position, :board, :color

    def initialize(color, board, position)
        @board, @color, @position = board, color, position
    end

end

