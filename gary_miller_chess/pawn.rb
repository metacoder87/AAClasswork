


class Pawn < Piece

    def initialize(board, position, color = nil)
        super
        @color = color || set_color
    end

    def set_color
        x, y = @position
        return "black" if x == 0 || x == 1
        return "white" if x == 6 || x == 7
    end

    def symbol
        x, y = @position
        return :♟p if x == 1
        return :♙p 
    end

    def moves
        x, y = @position
        mov = []
        mov << [x + forward_dir, y] if @color == "white"
        mov << [x + 1, y] if @color == "black"
        mov << [x + 2, y] if @color == "black" && x == 1
        mov << [x - 2, y] if @color == "white" && x == 6
        return mov   
    end

private

    def at_start_row?
        return true if @color == "black" && @position.first == 1
        return true if @color == "white" && @position.first == 6
        false
    end

    def forward_dir # => returns 1 || -1
        return -1 if @color == "white"
        return 1 if @color == "black"
    end

    def forward_steps
        return 2 if at_start_row?
        return 1
    end

    def side_attacks
        attacks = []
        x, y = @position
        x2 = x += forward_dir
        l_attack = [x2, y - 1]
        r_attack = [x2, y + 1]
        if !@board.l_attack.empty? && @board.l_attack.color != self.color
            attacks << l_attack
        elsif !@board.r_attack.empty? && @board.r_attack.color != self.color
            attacks << r_attack
        end
        return attacks
    end

end