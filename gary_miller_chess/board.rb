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
    end

end