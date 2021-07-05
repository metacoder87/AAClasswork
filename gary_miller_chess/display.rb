require 'colorize'
require 'byebug'

files = ['board', 'cursor']
files.each { |file| require_relative file }

class Display

    attr_accessor :board, :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        spots, grid, avail_moves, safe_moves, chosen = [], [], [], [], []
        chosen = @cursor.selected[0] if @cursor.selected.first
        x, y = chosen
        @board[x,y].moves.each { |move| avail_moves << move } if chosen.first && @board[x,y].moves
        @board[x,y].valid_moves.each { |move| safe_moves << move } if chosen.first && @cursor.helper == true && @board[x,y].valid_moves

        @board.rows.each_with_index do |row, idx|
            arr = []
            row.each_with_index do |col, i|
                if [idx, i] == chosen
                    arr << col.symbol.to_s.blue.on_green
                    spots << [idx, i]
                elsif [idx, i] == @cursor.cursor_pos && !spots.include?([idx, i])
                    arr << col.symbol.to_s.blue.on_white
                    spots << [idx, i]
                    puts "This spot leaves you in check..." if chosen.first && @board[x, y].move_into_check?([idx, i])
                elsif safe_moves.include?([idx, i]) && !spots.include?([idx, i])
                    arr << col.symbol.to_s.black.on_green
                    spots << [idx, i]
                elsif avail_moves.include?([idx, i]) && !spots.include?([idx, i])
                    arr << col.symbol.to_s.black.on_blue
                    spots << [idx, i]
                elsif col.color.nil? && !spots.include?([idx, i])
                    arr << col.symbol.to_s.black.on_black
                    spots << [idx, i]
                elsif col.color == "black" && !spots.include?([idx, i])
                    arr << col.symbol.to_s.black.on_red
                    spots << [idx, i] 
                elsif col.color == "white" && !spots.include?([idx, i])
                    arr << col.symbol.to_s.white.on_black
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

#dis.free_move       