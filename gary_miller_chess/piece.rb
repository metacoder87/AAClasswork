class Piece

    attr_accessor :position, :board, :color

    def initialize(board, position)
        @board, @position, @color, @symbol = board, position, color, symbol
    end

    def moves
        # Each subclass moves differently.
        puts "No moves available."
    end

    def to_s
        @color.to_s
    end

    def empty?
        @color == :__
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

    def color
        x, y = @position
        return "black" if x == 0 || x == 1
        return "white" if x == 6 || x == 7
    end

    def symbol
        return :_
    end

    def move_into_check?(end_pos)

    end

end

