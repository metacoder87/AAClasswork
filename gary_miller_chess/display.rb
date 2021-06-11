require 'colorize'

files = ['board', 'cursor']
files.each { |file| require_relative file }

class Display

    attr_accessor :board, :cursor

    def initialize
        @board = Board.new
        @cursor = Cursor.new([0,0], board)
    end

    def render
        grid = []
        @board.rows.each_with_index do |row, idx|
            arr = []
            row.each_with_index do |col, i|
                    unless col.position == cursor.cursor_pos || [idx, i] == cursor.cursor_pos && col.position.nil?
                        if col.color == "black"
                            arr << col.symbol.to_s.black.on_white
                        elsif col.color == "white" 
                            arr << col.symbol.to_s.white.on_black
                        else arr << col.symbol.to_s.black.on_black
                        end
                    else 
                        if @cursor.selected
                            arr << col.symbol.to_s.blue.on_green
                            @board.picked << [idx, i]
                        else arr << col.symbol.to_s.red.on_light_yellow
                        end
                    end
                end
                grid << arr
            end
        grid.each { |row| puts row.join(" ") }
        return 
    end
    
    def free_move
        x = 1
        while x
        render
        @cursor.get_input
        end
    end

end

dis = Display.new
dis.free_move