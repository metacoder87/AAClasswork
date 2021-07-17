class Player

    attr_accessor :display

    def initialize(display, color)
        @display = display
        @color = color
    end

    def opposite_color
        return "black" if @color == "white" 
        return "white" if @color == "black"
    end

end

class HumanPlayer < Player

    def make_move
        unless @display.cursor.selected.count == 2
            @display.cursor.get_input
        end
    end

end

class ComputerPlayer < Player

    def make_move
        king = @display.board.find_king(opposite_color)


        unless @display.cursor.selected.count == 2
            @display.board.all_pieces['color'].select { |piece| } #...come back for the bonus so you can move on with the course. 
        end
    end

end
