require 'singleton'


class NullPiece < Piece
    include Singleton

    attr_reader :color
    
    def initialize
        @color = symbol
    end

    def moves
        
    end

    def symbol
        return :__
    end

end