class Piece

    attr_accessor :position, :board, :color, :symbol

    def initialize(board, position)
        @board, @position, @color, @symbol = board, position, set_color, symbol
    end

    def moves
        # Each subclass moves differently.
        puts "No moves available."
    end

    def to_s
        @color.to_s
    end

    def empty?
        @color == nil
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

    def set_color
        x, y = @position
        return "black" if x == 0 || x == 1
        return "white" if x == 6 || x == 7
    end

    def symbol
        return :__
    end

    def move_into_check?(end_pos)
    def all_p
        pieces = { "white" => [], "black" => [] }
        @board.each do |row|
            row.each do |piece|
                if piece.symbol == :__ 
                    next
                else 
                    pieces[piece.color] << [piece.class, piece.position]
                end
            end
        end
        return pieces
    end

    def all_m(color)
        moves = []
        all_p[color].each do |piece| 
            x, y = piece.last
            @board[x][y].moves.each { |move| moves << move unless @board[x][y].moves.empty? || moves.include?(move) }
        end
        return moves
    end

    def find_boss(color)
        all_p[color].select { |piece| piece.include?(King) }.first.last
    end

    def checked?
        all_m(opposite_color).include?(find_boss(color))
    end

end

