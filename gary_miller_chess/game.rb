files = ['board', 'display', 'player']
files.each { |file| require_relative file }

class Game

    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players_hash = { "white" => nil, "black" => nil }
        player_prompt
    end

    def opposite_color(color)
        return "black" if color == "white" 
        return "white" if color == "black"
    end

    def make_player(type, color)
        return HumanPlayer.new(@display, color) if type == 'human'    
        return ComputerPlayer.new(@display, color) if type == 'computer'
    end

    def player_prompt
        puts '1 Player or 2?'
        num_players = gets.chomp.to_i until num_players == 1 || num_players == 2
        if num_players == 1
            puts 'Do you want to be White or Black?'
            color_choice = gets.chomp.to_s.downcase until color_choice == "white" || color_choice == "black"
            @players_hash[color_choice] = make_player('human', color_choice)
            @players_hash[opposite_color(color_choice)] = make_player('computer', opposite_color(color_choice))
        else 
            @players_hash["white"] = make_player('human', "white")
            @players_hash["black"] = make_player('human', "black")
        end
        @players = [@players_hash.values.first, @players_hash.values.last]
        @colors = [@players_hash.keys.first, @players_hash.keys.last]
        @current_player = @players.first
        @current_color = @colors.first
    end

    def boop
        duplicate_board = []
        @board.rows.each do |row|
            ro = []
            row.each do |spot|
                ro << spot
            end
            duplicate_board << ro
        end
        return duplicate_board
    end


    def play
        boo = boop
        until @board.checkmate?(@current_color)
            if @board.rows == boo
                system 'clear'
                notify_players
                @display.render
                @current_player.make_move
            else
                swap_turn!
                boo = boop
            end
        end
    end

    def notify_players
        p "#{@current_color.capitalize} it is your turn."
    end

    def swap_turn!
        @players.rotate!
        @colors.rotate!
        @current_player = @players.first
        @current_color = @colors.first
    end

end

Game.new.play