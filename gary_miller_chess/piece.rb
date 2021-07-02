require 'byebug'
class Piece

    attr_accessor :position, :board, :color, :symbol

    def initialize(board, position, color = nil)
        @board, @position, @color, @symbol = board, position, color || set_color, symbol
    end

    def opposite_color
        return "black" if @color == "white" 
        return "white" if @color == "black"
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
        moves.select { |move| move unless move_into_check?(move) }
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

    def small_move(end_pos)
        x, y = @position
        a, b = end_pos
        raise "That space is between pieces at the moment. Try again." unless @board[x][y].is_a?(Piece)
        raise "Can't move there." unless !@board[a][b].empty? || a < 8 && b < 8
        piece = @board[x][y]
        piece.position = end_pos
        @board[a][b] = piece
        @board[x][y] = NullPiece.instance
    end

    def move_into_check?(end_pos)
        x, y = end_pos
        start = @position
        color = @board[x][y].color
        hold_piece = @board[x][y].class unless @board[x][y].is_a?(NullPiece)
        small_move(end_pos)
        check = checked?
        small_move(start)
        @board[x][y] = hold_piece.new(@board, end_pos, color) if hold_piece
        return check
    end

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

