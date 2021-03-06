files = ['piece', 'rook', 'knight', 'bishop', 'pawn', 'king', 'queen', 'null_piece']
files.each { |file| require_relative file }
require 'byebug'
class Board

    attr_reader :rows

    def initialize
        @rows = Array.new(8) { Array.new(8) }
        populate
    end

    def populate
        board = @rows.dup
        @rows.each_with_index do |row, idx|
            row.map!.with_index do |col, i|
                if idx == 0 || idx == 7
                    if i == 0 || i == 7
                        col = Rook.new(board, [idx, i])
                    elsif i == 1 || i == 6
                        col = Knight.new(board, [idx, i])
                    elsif i == 2 || i == 5
                        col = Bishop.new(board, [idx, i])
                    elsif i == 3 
                        col = Queen.new(board, [idx, i])
                    else col = King.new(board, [idx, i])
                    end
                elsif idx == 1 || idx == 6
                    col = Pawn.new(board, [idx, i])
                else col = NullPiece.instance
                end
            end
        end
    end

    def all_pieces
        pieces = { "white" => [], "black" => [] }
        @rows.each do |row|
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

    def find_king(color)
        all_pieces[color].select { |piece| piece.include?(King) }.first.last
    end

    def all_moves(color)
        moves = []
        all_pieces[color].each do |piece| 
            x, y = piece.last
            @rows[x][y].moves.each { |move| moves << move unless @rows[x][y].moves.empty? || moves.include?(move) }
        end
        return moves
    end

    def [](pos_x, pos_y)
        x, y = pos_x, pos_y
        @rows[x][y]
    end

    def []=(pos_x, pos_y, val)
       move_piece([pos_x, pos_y], val)
    end

    def move_piece(start_pos, end_pos)
        raise "That space is between pieces at the moment. Try again." unless @rows[start_pos[0]][start_pos[1]].is_a?(Piece)
        raise "Can't move there." unless !@rows[end_pos[0]][end_pos[1]].empty? || end_pos[0] < 8 && end_pos[1] < 8
        piece = @rows[start_pos[0]][start_pos[1]]
        piece.position = end_pos
        @rows[end_pos[0]][end_pos[1]] = piece
        @rows[start_pos[0]][start_pos[1]] = NullPiece.instance
    end

    def valid_pos(pos)
        x, y = pos
        return true if (0..7).include?(x) && (0..7).include?(y)
        false
    end

    def opposite_color(color)
        return "black" if color == "white" 
        return "white" if color == "black"
    end

    def in_check?(color)
        all_moves(opposite_color(color)).include?(find_king(color))
    end

    def checkmate?(color)
        if in_check?(color)
            x, y = find_king(color)
            return @rows[x][y].moves.all? { |move| all_moves(opposite_color(color)).include?(move) }                
        end
        return false
    end

end

# board.move_piece([1,4],[2,5])
# board.move_piece([1,3],[2,6])
# board = Board.new
# board.move_piece([1,0],[3,0])
# board.move_piece([1,1],[3,1])
# board.move_piece([1,2],[3,2])
# board.move_piece([1,3],[3,4])
# board.move_piece([1,4],[3,5])
# board.move_piece([7,3],[2,2])
# board.move_piece([7,2],[2,3])