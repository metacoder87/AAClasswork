require_relative 'slideable'

# Creates the Bishop class and includes superclass Piece
class Bishop < Piece
    include Slideable # Module containing the move logic

    def initialize(board, position, color = nil)
        super # Gets board & position and calls set_color from Piece
        @color = color || set_color
    end

    def symbol # Uses Unicode to create a bishop chess piece
        return "\u265d"+"B"
    end

private

    def move_dirs # The bishop piece always moves in the diaganol direction
        diaganol_dirs
    end

end