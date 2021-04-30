require_relative 'piece'

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
                if idx == 0
                    if i == 0 || i == 7
                        col = Piece.new(:BR, board, [idx, i])
                    elsif i == 1 || i == 6
                        col = Piece.new(:Bk, board, [idx, i])
                    elsif i == 2 || i == 5
                        col = Piece.new(:BB, board, [idx, i])
                    elsif i == 3 
                        col = Piece.new(:BQ, board, [idx, i])
                    else col = Piece.new(:BK, board, [idx, i])
                    end
                elsif idx == 1
                    col = Piece.new(:BP, board, [idx, i])
                elsif idx == 6
                    col = Piece.new(:WP, board, [idx, i])
                elsif idx == 7
                    if i == 0 || i == 7
                        col = Piece.new(:WR, board, [idx, i])
                    elsif i == 1 || i == 6
                        col = Piece.new(:Wk, board, [idx, i])
                    elsif i == 2 || i == 5
                        col = Piece.new(:WB, board, [idx, i])
                    elsif i == 3
                        col = Piece.new(:WQ, board, [idx, i])
                    else col = Piece.new(:WK, board, [idx, i])
                    end
                end
            end
        end
    end

    def [](pos_x, pos_y)
        x, y = pos_x, pos_y
        @rows[x][y].color
    end

    def []=(pos_x, pos_y, val)
        x, y = pos_x, pos_y
        @rows[x][y].position = val
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
        raise "That space is between pieces at the moment. Try again." unless @rows[start_pos[0]][start_pos[1]].instance_of?(Piece)
        raise "Can't move there." unless @rows[end_pos[0]][end_pos[1]].nil? || end_pos[0] > 7 || end_pos[1] > 7
        piece = @rows[start_pos[0]][start_pos[1]]
        piece.position = end_pos
        @rows[end_pos[0]][end_pos[1]] = piece
        @rows[start_pos[0]][start_pos[1]] = nil 
    end

end