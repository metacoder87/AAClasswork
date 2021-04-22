require_relative 'piece'

class Board

    def initialize
        Array.new(8) { Array.new(Piece.new) }
    end

end