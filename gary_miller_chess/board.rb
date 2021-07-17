# Board uses a lot of files and I found this to be the best way to require many relatives.
files = ['piece', 'rook', 'knight', 'bishop', 'pawn', 'king', 'queen', 'null_piece']
files.each { |file| require_relative file }

class Board

    attr_reader :rows

    def initialize # Builds an 8 x 8 game board and sets pieces.
        @rows = Array.new(8) { Array.new(8) }
        populate
    end

    def populate # Creates a new instance for each piece.
        board = @rows
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

    def all_pieces # Locates all of the pieces on the board
        # It returns a Hash of each color
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

    def all_piece_pos # Returns an array of all the locations of each piece
        all_positions = []
        all_pieces.values.last.each { |p| all_positions << p.last }
        all_pieces.values.first.each { |p| all_positions << p.last }
        return all_positions
    end

    def find_king(color) # Locates the King for any given color at any time
        all_pieces[color].select { |piece| piece.include?(King) }.first.last
    end

    def all_moves(color) # Each move available on the whole board for a given color
        moves = []
        all_pieces[color].each do |piece| 
            x, y = piece.last
            @rows[x][y].moves.each { |move| moves << move unless @rows[x][y].moves.empty? || moves.include?(move) }
        end
        return moves
    end

    def [](x, y)
        @rows[x][y]
    end

    def []=(x, y, val)
       move_piece([x, y], val)
    end

    def move_piece(start_pos, end_pos) # Moves a piece to an available move.
        x, y = start_pos
        a, b = end_pos
        piece = @rows[x][y]
        plays = piece.moves
        if plays.include?(end_pos)
            piece.position = end_pos 
            @rows[a][b] = piece
            @rows[x][y] = NullPiece.instance
        end
         rescue RuntimeError
    end

    def move_piece!(start_pos, end_pos) # Moves piece despite availability
        x, y = start_pos
        a, b = end_pos
        piece = @rows[x][y] # MOOOVE PIECE!!!
        piece.position = end_pos # Get out the way!
        @rows[a][b] = piece # Get out the way piece!
        @rows[x][y] = NullPiece.instance # Get out the way!
    end

    def valid_pos(pos) # Determines if a given position is valid for that piece
        x, y = pos
        return true if (0..7).include?(x) && (0..7).include?(y)
        false
    end

    def opposite_color(color) # Returns the opposite color given a color
        return "black" if color == "white" 
        return "white" if color == "black"
    end

    def in_check?(color) # Determines if the Player is in check from a move
        all_moves(opposite_color(color)).include?(find_king(color))
    end

    def checkmate?(color) # Determines if the Player is in checkmate
        if in_check?(color)
            x, y = find_king(color)
            return @rows[x][y].moves.all? { |move| all_moves(opposite_color(color)).include?(move) }                
        end
        return false
    end

end