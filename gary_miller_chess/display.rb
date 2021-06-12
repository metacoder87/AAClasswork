require 'colorize'

files = ['board', 'cursor']
files.each { |file| require_relative file }

class Display

    attr_accessor :board, :cursor

    def initialize
        @board = Board.new
        @cursor = Cursor.new([0,0], board)
    end

    # def render
    #     grid = []
    #     @board.rows.each_with_index do |row, idx|
    #         arr = []
    #         row.each_with_index do |col, i|
    #                 unless col.position == cursor.cursor_pos || [idx, i] == cursor.cursor_pos && col.position.nil?
    #                     if col.color == "black"
    #                         arr << col.symbol.to_s.black.on_white
    #                     elsif col.color == "white" 
    #                         arr << col.symbol.to_s.white.on_black
    #                     else arr << col.symbol.to_s.black.on_black
    #                     end
    #                 else 
    #                     if @board.picked.count == 1
    #                         arr << col.symbol.to_s.blue.on_green
    #                         @board.picked << [idx, i]
    #                     else arr << col.symbol.to_s.red.on_light_yellow
    #                     end
    #                 end
    #             end
    #             grid << arr
    #         end
    #     grid.each { |row| puts row.join(" ") }
    #     return 
    # end

    def render
        moves = []
        grid = []

        cursed = @cursor.cursor_pos
        @board.picked << cursed if @cursor.selected
        chosen = 0 || chosen = @board.picked[0] if @board.picked

        @board.rows.each_with_index do |row, idx|
            arr = []
            row.each_with_index do |col, i|
                if col.position == chosen 
                    arr << col.symbol.to_s.green.on_blue
                elsif col.position == cursed && col.position != chosen || col.position.nil?
                    arr << col.symbol.to_s.black.on_blue
                elsif moves.include?(col.position)
                    arr << col.symbol.to_s.blue.on_green
                elsif col.position.nil? && col.position != cursed && !moves.include?(col.position)
                    arr << col.symbol.to_s.black.on_black
                elsif col.color == "black" && !moves.include?(col.position) && col.position != chosen || col.position != cursed
                    arr << col.symbol.to_s.white.on_black
                elsif col.color == "white" && !moves.include?(col.position) && col.position != chosen || col.position != cursed
                    arr << col.symbol.to_s.black.on_white
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