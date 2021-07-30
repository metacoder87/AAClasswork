require 'byebug'
files = ['board', 'display', 'player']
files.each { |file| require_relative file }

class Game

    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players_hash = { "white" => nil, "black" => nil } # => stores the Player data under 'white' or 'black'
        player_prompt
    end

    def opposite_color(color) # => Returns the other color based on the input color
        return "black" if color == "white" 
        return "white" if color == "black"
    end

    def make_player(type, color) # => Creates a new instance of a type of Player 
        return HumanPlayer.new(@display, color) if type == 'human'    
        return ComputerPlayer.new(@display, color) if type == 'computer'
    end

    def player_prompt
        # puts '1 Player or 2?'
        # num_players = gets.chomp.to_i until num_players == 1 || num_players == 2
        num_players = 2
        if num_players == 1 # => If a 1 Player game, it creates a Human & Computer Player instances
            puts 'Do you want to be White or Black?'
            color_choice = gets.chomp.to_s.downcase until color_choice == "white" || color_choice == "black"
            @players_hash[color_choice] = make_player('human', color_choice)
            @players_hash[opposite_color(color_choice)] = make_player('computer', opposite_color(color_choice))
        else # => If a 2 player game, it creates 2 Human Players
            @players_hash["white"] = make_player('human', "white")
            @players_hash["black"] = make_player('human', "black")
        end 
        # => Creates variables to acces the parts of Player data and create current variables for turn taking.
        @players = [@players_hash.values.first, @players_hash.values.last]
        @colors = [@players_hash.keys.first, @players_hash.keys.last]
        @current_player = @players.first
        @current_color = @colors.first
    end
    
    def play # => Loops between players until checkmate is reached
        black_turn = false
        until @board.checkmate?(@current_color)
                system 'clear'
                notify_players
                @display.render
                @current_player.make_move
            if @display.cursor.number_of_white_moves > @display.cursor.number_of_black_moves && black_turn == false
                swap_turn!
                black_turn = true
            elsif @display.cursor.number_of_white_moves == @display.cursor.number_of_black_moves && black_turn == true
                swap_turn!
                black_turn = false
            end
        end
        p "#{@current_color.capitalize}, you have won the game."
        sleep (5)
    end

    def notify_players # => Outputs a string about the players turn
        p "#{@current_color.capitalize} it is your turn."
    end

    def swap_turn! # => Switches between players
        @players.rotate!
        @colors.rotate!
        @current_player = @players.first
        @current_color = @colors.first
    end

end

Game.new.play