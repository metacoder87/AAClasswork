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
        spots, grid, moves, chosen = [], [], [], []
        chosen = @cursor.selected[0] if @cursor.selected.first
        x, y = chosen
        @board.rows[x][y].moves.each { |move| moves << move } if chosen.first && @board.rows[x][y].moves

        @board.rows.each_with_index do |row, idx|
            arr = []
            row.each_with_index do |col, i|
                if [idx, i] == chosen
                    arr << col.symbol.to_s.blue.on_green
                    spots << [idx, i]
                elsif [idx, i] == @cursor.cursor_pos && !spots.include?([idx, i])
                    arr << col.symbol.to_s.blue.on_white
                    spots << [idx, i]
                elsif moves.include?([idx, i]) && !spots.include?([idx, i])
                    arr << col.symbol.to_s.green.on_black
                    spots << [idx, i]
                elsif col.color.nil? && !spots.include?([idx, i])
                    arr << col.symbol.to_s.black.on_black
                    spots << [idx, i]
                elsif col.color == "black" && !spots.include?([idx, i])
                    arr << col.symbol.to_s.black.on_red
                    spots << [idx, i] 
                elsif col.color == "white" && !spots.include?([idx, i])
                    arr << col.symbol.to_s.white.on_red
                    spots << [idx, i]
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
        system 'clear'
        render
        @cursor.get_input
        end
    end

end

dis = Display.new
dis.free_move