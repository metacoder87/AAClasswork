


class Pawn < Piece

    def symbol
        return :BP if @position.first == 1
        return :WP 
    end

    def moves
        x, y = @position
        mov = []
        mov << [x + forward_dir, y] if @color == :WP
        mov << [x + 1, y] if @color == :BP
        mov << [x + 2, y] if @color == :BP && x == 1
        mov << [x - 2, y] if @color == :WP && x == 6
        return mov   
    end

private

    def at_start_row?

    end

    def forward_dir # => returns 1 || -1
        return -1 if @color == :WP
        return 1 if @color == :BP
    end

    def forward_steps
        x, y = @position
        return 2 if x == 1 && @color == :BP
        return 2 if x ==  
    end

    def side_attacks

    end

end