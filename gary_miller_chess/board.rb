files = ['piece', 'rook', 'knight', 'bishop', 'pawn', 'king', 'queen', 'null_piece']
files.each { |file| require_relative file }

class Board

    attr_reader :rows, :blank

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

    def [](pos_x, pos_y)
        x, y = pos_x, pos_y
        @rows[x][y].color
    end

    def []=(pos_x, pos_y, val)
       move_piece([pos_x, pos_y], val)
    end

    def render
        grid = []
        @rows.each do |row|
            arr = []
            row.each do |col|
                    if col
                        arr << col.color
                    else arr << col
                    end
                end
                grid << arr
            end
        grid.each { |row| puts row.join(" ") }
    end

    def move_piece(start_pos, end_pos)
        raise "That space is between pieces at the moment. Try again." unless @rows[start_pos[0]][start_pos[1]].is_a?(Piece)
        raise "Can't move there." unless !@rows[end_pos[0]][end_pos[1]].empty? || end_pos[0] < 8 && end_pos[1] < 8
        piece = @rows[start_pos[0]][start_pos[1]]
        piece.position = end_pos
        @rows[end_pos[0]][end_pos[1]] = piece
        @rows[start_pos[0]][start_pos[1]] = NullPiece.instance
        return render
    end

end