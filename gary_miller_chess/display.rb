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
                    if col
                        arr << col.color
                    else arr << col
                    end
                end
                grid << arr
            end
        grid.each { |row| puts row.join(" ") }
    end

end