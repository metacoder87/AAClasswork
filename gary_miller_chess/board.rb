require_relative 'piece'

class Board

    attr_reader :rows

    def initialize
        @rows = Array.new(8) { Array.new(8) }
        populate
    end

    def populate
        @rows.each_with_index do |row, idx|
            row.map!.with_index do |col, i| 
                if idx == 0 || idx == 1 
                    col = Piece.new("black", @rows, [idx, i]) 
                elsif idx == 6 || idx == 7 
                    col = Piece.new("white", @rows, [idx, i])
                end
            end
        end
    end

    def [](pos)
        x, y = pos
        @rows[x][y]
    end

    def []=(pos, val)
        x, y = pos
        @rows[x][y]
    end

    def move_piece(start_pos, end_pos)
        raise "That space is between pieces at the moment. Try again." unless @rows[start_pos[0]][start_pos[1]].instance_of?(Piece)
        raise "Can't move there." unless @rows[end_pos[0]][end_pos[1]].nil? || end_pos[0] > 7 || end_pos[1] > 7
        piece = @rows[start_pos[0]][start_pos[1]]
        piece.position = end_pos
        @rows[end_pos[0]][end_pos[1]] = piece
        @rows[start_pos[0]][start_pos[1]] = nil 
    end

end