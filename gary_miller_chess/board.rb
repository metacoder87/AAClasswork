require_relative 'piece'

class Board

    attr_reader :rows

    def initialize
        @rows = Array.new(8) { Array.new(8) }
        populate
    end

    def populate
        @rows.each_with_index do |row, idx|
            row.map!.with_index { |col, i| col = Piece.new([idx, i]) } if idx == 0 || idx == 1 || idx == 6 || idx == 7 
        end
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