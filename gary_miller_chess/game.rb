require_relative 'board'
require_relative 'display'

class Game

    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players = { "white" => nil, "black" => nil }
        player_prompt
        @current_player = @players.values.first
    end

    def player_prompt
        puts '1 Player or 2?'
        num_players = gets.chomp.to_i until num_players == 1 || num_players == 2
        puts 'Do you want to be White or Black?'
        color_choice = gets.chomp.to_s until color_choice == "white" || color_choice == "black"
    end


    def play

    end

    def notify_players

    end

    def swap_turn!

    end

end