class Piece

    attr_accessor :position, :board, :color

    def initialize(color, board, position)
        @board, @color, @position = board, symbol, position
    end

    def moves
        # Each subclass moves differently.
    end

    def to_s
        @color.to_s
    end

    def empty?
        @color == :_
    end

    def valid_moves
        moves.select do |move|
            x, y = move 
            @board[x, y].empty?
        end
    end

    def pos=(val)
        @position = val
    end

    def symbol
        return :_
    end

    def move_into_check?(end_pos)
        
    end

end

