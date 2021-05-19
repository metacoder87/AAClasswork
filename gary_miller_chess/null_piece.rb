require 'singleton'


class NullPiece < Piece
    include Singleton
    
    def initialize
        @symbol = symbol
    end
    
    def symbol
        return :__
    end

end