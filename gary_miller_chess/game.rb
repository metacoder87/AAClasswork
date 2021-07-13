require 'byebug'
require_relative 'board'
require_relative 'display'
require_relative 'player'

class Game
    
    attr_accessor :board, :display, :players_hash, :players, :colors, :current_color, :current_player, :player

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

    def make_player(type)
        #debugger
        return HumanPlayer.new(@display) if type == 'human'
        return ComputerPlayer.new(@display) if type == 'computer'
    end

    def player_prompt
        puts '1 Player or 2?'
        num_players = gets.chomp.to_i until num_players == 1 || num_players == 2
        if num_players == 1
            puts 'Do you want to be White or Black?'
            color_choice = gets.chomp.to_s.downcase until color_choice == "white" || color_choice == "black"
            @players_hash[color_choice] = make_player('human')
            @players_hash[opposite_color(color_choice)] = make_player('computer')
        else 
            player_1 = make_player('human')
            @players_hash["white"] = player_1
            @players_hash["black"] = make_player('human')
        end
        @players = [@players_hash.values.first, @players_hash.values.last]
        @colors = [@players_hash.keys.first, @players_hash.keys.last]
        @current_player = @players.first
        @current_color = @colors.first
    end


    def play
        boo = boop
        until @board.checkmate?(@current_color)
            if @board.rows == boo
                system 'clear'
                @display.render
                @current_player.make_move
            else
                swap_turn!
                boo = boop
            end
        end
    end

    def notify_players
        puts "#{@current_color.capitalize} it is your turn."
    end

    def swap_turn!
        @players.rotate!
        @colors.rotate!
    end

end

# game = Game.new
# game.play