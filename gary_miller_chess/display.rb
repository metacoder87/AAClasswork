require 'colorize'
require_relative 'cursor'

class Display

    attr_accessor :board, :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        grid = []
        @board.rows.each do |row|
            arr = []
            row.each do |col|
                    unless col.position == cursor.cursor_pos
                        if col.color == "black"
                            arr << col.symbol.to_s.black.on_white
                        elsif col.color == "white" 
                            arr << col.symbol.to_s.white.on_black
                        else arr << col.symbol.to_s.black.on_black
                        end
                    else arr << col.symbol.to_s.red.on_light_yellow
                    end
                end
                grid << arr
            end
        grid.each { |row| puts row.join(" ") }
        return 
    end

end