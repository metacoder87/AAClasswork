class Player

    attr_accessor :display

    def initialize(display)
        @display = display
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
    end

end
