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

                if idx == 0 || idx == 7 # Places pieces on two rows with all non-pawns

                    if i == 0 || i == 7 # Places the Rooks in their place
                        col = Rook.new(board, [idx, i])

                    elsif i == 1 || i == 6 # Places the Knights
                        col = Knight.new(board, [idx, i])

                    elsif i == 2 || i == 5 # Places the Bishops
                        col = Bishop.new(board, [idx, i])

                    elsif i == 3 # Places the Queens & Kings
                        col = Queen.new(board, [idx, i])
                    else col = King.new(board, [idx, i])
                    end

                elsif idx == 1 || idx == 6 # Places all of the Pawns
                    col = Pawn.new(board, [idx, i])

                    # Fills the empty space with a Singleton
                else col = NullPiece.instance
                end
            end
        end
    end

    def all_pieces # Locates all of the pieces on the board
        # Creates a hash of arrays for the colors to store the pieces
        pieces = { "white" => [], "black" => [] }

        @rows.each do |row| # Looks at each row

            row.each do |piece| # Looks at each piece

                if piece.symbol == :__
                    next # Skips empty spaces

                else # Collects all of the pieces and sorts by color 
                    pieces[piece.color] << [piece.class, piece.position]
                end
            end
        end
        # It returns a Hash of each color and their pieces
        return pieces
    end

    def all_piece_pos # Get location on board of each piece
        all_positions = [] # Empty array for storing locations

        # Saves the piece
        all_pieces.values.last.each { |p| all_positions << p.last } 
        # Saves the location of that piece
        all_pieces.values.first.each { |p| all_positions << p.last }

        # Returns an array of all the locations of each piece
        return all_positions
    end

    def find_king(color) # Locates the King for any given color at any time
        all_pieces[color].select { |piece| piece.include?(King) }.first.last
    end

    def all_moves(color) # Each move available on the whole board for a given color
        moves = [] # Location to house all moves for a color

        all_pieces[color].each do |piece| # Iterates through all the pieces for a given color

            x, y = piece.last # Saves the location as x & y coordinates
            # Iterates through the moves for a piece and saves that move if it exists and hasn't previously been saved
            @rows[x][y].moves.each { |move| moves << move unless @rows[x][y].moves.empty? || moves.include?(move) }
        end
        return moves # Returns the moves for a color
    end

    def [](x, y) # Allows syntactical sugar for location access
        @rows[x][y]
    end

    def []=(x, y, val) # Allows syntactical sugar for location storing of values
       move_piece([x, y], val)
    end

    def move_piece(start_pos, end_pos) # Moves a piece to an available move.
        # Saves coordinate variables for the positions
        x, y = start_pos 
        a, b = end_pos
        # Saves the piece at the start location to a variable, piece
        piece = @rows[x][y]
        # Saves the moves for that piece
        plays = piece.moves

        if plays.include?(end_pos) # Checks if ending location is a known move
            # Saves the ending location as the location of the piece
            piece.position = end_pos 
            # Save the piece to the location on the board
            @rows[a][b] = piece
            # Makes the space the piece was located an empty space
            @rows[x][y] = NullPiece.instance
        end
         # Saves the code from a run time error
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

    def valid_pos(pos) # Determines if a given position is on the board
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
        
        if in_check?(color) # Checks for check

            x, y = find_king(color) # Saves the King's location as coordinates x & y
            # Checks if any moves get the color out check, if not CHECKMATE
            return @rows[x][y].moves.all? { |move| all_moves(opposite_color(color)).include?(move) }                
        end

        return false
    end

end