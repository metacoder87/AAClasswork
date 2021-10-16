require 'byebug'


# Poker

# Today we will be using TDD to write a poker game, specifically five card draw.
# https://en.wikipedia.org/wiki/Five-card_draw


# Learning Goals

# Be able to define desired functionality, write specs, and then implement
# Know how to follow red, green, refactor TDD workflow
# Know how to create and use test doubles
# Know when to use context and describe
# You'll want to use betterspecs as a cheatsheet/reference.
# https://www.betterspecs.org/
# You'll also want to refer to the reading on 
# test doubles for help creating unit tests.
# https://open.appacademy.io/learn/full-stack-online/ruby/test-doubles


# Rules

# Each player is dealt five cards.
# Players bet; each player may fold, see the current bet, or raise.
# In turn, each player can choose to discard up to three cards.
# They are dealt new cards from the deck to replace their old cards.
# Players bet again.
# If any players do not fold, 
# then players reveal their hands; 
# strongest hand wins the pot.
# https://en.wikipedia.org/wiki/List_of_poker_hands


# Design

# Classes you will want:
# Card

class Card # This class represents each individual card in the deck

    attr_reader :suit, :value

    def initialize(suit, value)
        @suit, @value = suit, value
    end

end

# Deck

class Deck

    attr_reader :cards

    def initialize # Creates a deck of cards
        @cards = deck_builder
    end

    def value_array # An array of all possible values in a deck
        base_vals = [2,3,4,5,6,7,8,9,10]
        face_vals = [:Jack,:Queen,:King,:Ace]
        return base_vals + face_vals
    end

    def suit_hasher # A hash table of all the suits in a deck
        suits = [:hearts,:clubs,:diamonds,:spaids]
        cards = {}
        suits.each do |suit|
            cards[suit] = []
        end
        return cards
    end

    def deck_builder # Fills in the hash table so the each suit holds all values
        cards = suit_hasher
        cards.keys.each do |suit|
            value_array.each do |val|
                cards[suit] << Card.new(suit, val)
            end
        end
        return cards
    end

end

    # Request a TA Code review

# Hand
    # The logic of calculating pair, three-of-a-kind, two-pair, etc. goes here.
    # Logic of which hand beats which would go here.

class Hand

    attr_accessor :cards, :values

    def initialize(cards = []) 
        @cards = cards # Holds all the cards for a players hand
        @values = [] # Tracks a numerical value of each card in hand
    end

    def sort_vals # Assigns a numerical value for each card
        @values.clear
        @cards.each do |card|
            if card.value.class == Integer
                @values << card.value
            elsif card.value == :Jack
                @values << 11
            elsif card.value == :Queen
                @values << 12
            elsif card.value == :King
                @values << 13
            elsif card.value == :Ace
                @values << 1
                @values << 14
            end
        end
    end

    def card_count # Creates a hash of how many of each card
        cnt = {}
        @cards.each { |card| cnt[card.value] = 0 }
        @cards.each { |card| cnt[card.value] += 1 }
        return cnt
    end

    def high_card #Determines the card with highest value on hand
        if @values.count > 5
            return :ace_high
        end
        if @values.sort.last < 11
            puts "you've got #{@values.sort.last} high"
            return @values.sort.last
        else 
            if @values.sort.last == 13
                return :king_high
            elsif @values.sort.last == 12
                return :queen_high
            elsif @values.sort.last == 11
                return :jack_high
            end
        end
    end


    def pair? # Checks the hand for pairs
        card_count.any? { |card, count| count == 2 }
    end

    def two_pair? # Checks the hand for 2 pairs
        card_count.select { |card, count| count == 2 }.count == 2
    end

    def three_of_kind? # Checks the hand for 3 of a kind
        card_count.any? { |card, count| count == 3 }
    end

    def straight? # Checks the hand for a straight
        @values.sort[-1] - @values.sort[0] == 4
    end

    def flush? # Checks the hand for a flush
        @cards.all? { |card| card.suit == @cards[0].suit }
    end

    def full_house? # Checks the hand for a full house
        return three_of_kind? && pair?
    end

    def straight_flush? # Checks the hand for a straight flush
        return straight? && flush?
    end

    def four_of_a_kind? # Checks the hand for 4 of a kind
        card_count.any? { |card, count| count == 4 }
    end

    def rank # Analyzes the over all value of the hand as a whole
        sort_vals
        if four_of_a_kind?
            return :four_of_a_kind
        elsif straight_flush?
            return :straight_flush
        elsif full_house?
            return :full_house
        elsif flush?
            return :flush
        elsif straight?
            return :straight
        elsif three_of_kind?
            return :three_of_kind
        elsif two_pair?
            return :two_pair
        elsif pair?
            return :pair
        else
            return high_card
        end
    end

    def weight # Assigns a numerical value to the hand by rank
        tie_breaker = @values.sort.last
        if rank == :pair
            return 15 + tie_breaker
        elsif rank == :two_pair
            return 16 + tie_breaker
        elsif rank == :three_of_kind
            return 17 + tie_breaker
        elsif rank == :straight
            return 18 + tie_breaker
        elsif rank == :flush
            return 19 + tie_breaker
        elsif rank == :full_house
            return 20 + tie_breaker
        elsif rank == :straight_flush
            return 21 + tie_breaker
        elsif rank == :four_of_a_kind
            return 22 + tie_breaker
        elsif high_card == :ace_high
            return 14 + tie_breaker
        elsif high_card == :king_high
            return 13 + tie_breaker
        elsif high_card == :queen_high
            return 12 + tie_breaker
        elsif high_card == :jack_high
            return 11 + tie_breaker
        else return high_card + tie_breaker
        end
    end

end

# Player
    # Each player has a hand, plus a pot
    # Player has methods to ask the user:
        # Which cards they wish to discard
        # Whether they wish to fold, see, or raise.

class Player

    attr_accessor :hand, :chips, :players_bet, :rating, :name 

    def initialize(chips, name, hand = Hand.new) # Creates the player to hold a hand and chips
        @chips, @name, @hand, @players_bet = chips, name, hand, 0
    end

    def see_hand # Outputs a display of the hand
        c = []
        @hand.cards.each do |card|
            if card.suit == :hearts
                c << [card.value,"\u2661"]
            elsif card.suit == :spaids
                c << [card.value,"\u2660"]
            elsif card.suit == :diamonds
                c << [card.value,"\u2662"]
            else c << [card.value,"\u2663"]
            end
        end
        c.map! { |card| card.join() }.join(',')
        c.sort.each { |card| print card + " " }
    end

    def fold # forfeits the hand of cards and right to play to the showdown
        @hand.cards = []
    end

    def has_hand? # Determines if the players has folded
        return false if @hand.cards.empty?
        return true
    end

    def antie_up? # Asks the user if they want to play the hand they were dealt
        system 'clear'
        see_hand # shows hand to player
        puts "\n#{@name} you have #{@chips} chips."
        puts "15 chips to play your hand."
        puts "Do you want to play? (y/n)"
        response = gets.chomp.to_s
        if response == "y"
            return true
        elsif response == "n"
            fold
            return false 
        else antie_up?
        end
    end

    def trade? # Asks the player if they want to exchange any cards
        system 'clear'
        puts "You can trade up to 3 cards..."
        puts "Don't want to trade? Press ENTER"
        puts "Enter cards in format, 3H, AD, 10S"
        puts "3 of Hearts as 3H, Ace of Diamonds as AD"
        see_hand
        puts "\n"
        trades = gets.chomp.to_s.split(",")
        return 0 if trades.empty?
        n = trades.count
        if n > 0 && n < 4
            trades.each do |trade|
                val = trade.strip.split("").first
                sut = trade.strip.split("").last.downcase
                if trade.strip.length > 2
                    val = 10
                elsif val.downcase == "a"
                    val = :Ace
                elsif val.downcase == "k"
                    val = :King
                elsif val.downcase == "q"
                    val = :Queen
                elsif val.downcase == "j"
                    val = :Jack
                elsif (2..9).include?(val.to_i)
                    val = val.to_i
                end
                if sut == "h"
                    sut = :hearts
                elsif sut == "s"
                    sut = :spaids
                elsif sut == "d"
                    sut = :diamonds
                elsif sut == "c"
                    sut = :clubs
                end

                @hand.cards.delete_if { |card| card.suit == sut && card.value == val }
            end
        else trade?
        end

        return n
    end

    def action?(current_bet) # Asks each player what move they will make
        @bet = 0
        system 'clear'
        puts "#{@name}'s bet is #{@players_bet}"
        puts "You have #{@chips} chips"
        puts "Would you like to..."
        if current_bet == 0 # If no bets have been placed
            puts "fold, check, or bet?"
        elsif current_bet > 0 # If a bet has already been wagered
            puts "fold, call, or raise?"
            puts "Current bet is #{current_bet}"
        end
        see_hand
        response = gets.chomp.to_s
        responses = ["fold", "check", "bet", "raise", "call"]
        if responses.include?(response) 
            return response 
        else action?(current_bet)
        end
    end


    def bet(min) # Asks the players for an amount to bet and moves chips
        system 'clear'
        puts "What would you like to bet from #{min} to #{@chips}?"
        @players_bet = gets.chomp.to_i
        if (min..@chips).include?(@players_bet)
            @chips -= @players_bet
            return @players_bet
        else bet(min)
        end
    end

    def called(current_bet) # Moves chips into pot to match a previous bet
        if current_bet <= @chips # If player has enough chips to cover the bet
            @chips -= current_bet
            @players_bet = current_bet
            puts "#{@name}, called the bet"
            puts "and has #{@chips} chips remaining."
            sleep(3)
            return @players_bet
        elsif current_bet > @chips # If player goes all in to cover the bet
            @players_bet = current_bet
            b = @chips
            @chips = 0
            puts "#{@name}, called the bet"
            puts "and has #{@chips} chips remaining."
            sleep(3)
            return b
        end
        
    end

    def strength_rating # Assigns the overall value of the hand to a rating variable
        @rating = @hand.weight
    end

    def award(pot) # Adds a won pot to total chips
        @chips += pot
    end

end

# Game
    # Holds the deck
    # Keeps track of whose turn it is
    # Keeps track of the amount in the pot.

class Game

    attr_reader :deck, :players, :pot, :bet, :cards

    def initialize(num_players)
        @players = [] # Table for the players
        @deck = Deck.new # New deck of cards
        make_players(num_players) # Seats players at table
        @pot = 0 # Empty pot
        @bet = 0 # No bets yet
    end

    def make_players(n) # Initializes generic players to fill the requested number of seats
        p = 1
        until n == 0
            player_name = "Player" + p.to_s
            @players << Player.new(1500, player_name)
            n -= 1
            p += 1
        end
    end

    def shuffle_cards # Shuffles the deck of cards for randomness
        @cards = @deck.cards.values.flatten.shuffle
    end

    def deal_cards # Appropriates 5 cards to each player
        @players.each { |player| player.hand.cards = @cards.pop(5) }
    end

    def antie_up # Asks each player if they want to play the hand they were dealt
        @players.each do |player|
            player.players_bet = 0
            if player.antie_up? # Antie costs 15 for each player
                if player.chips >= 15
                    player.chips -= 15
                    @pot += 15
                elsif player.chips < 15 # Players can go all in on the antie
                    @pot += player.chips
                    player.chips = 0
                end
            end
        end
    end

    def trade_cards # Asks each player if they want to trade up to 3 cards
        @players.each do |player|
            trades = player.trade?
            player.hand.cards.push @cards.pop trades if trades > 0
            player.hand.cards.flatten!
            puts "Your new hand is..."
            player.see_hand # Shows the player their new hand
            sleep(5)
        end
    end

    def option # Asks each player what action they will take this round
        players_in_game.each do |player|
            if @bet == 0 || player.players_bet != @bet
                decision = player.action?(@bet)
                if decision == "bet" || decision == "raise"
                    # Increases chips in pot and puts further action on players
                    n = player.bet(@bet) 
                    if n > @bet
                        @bet = n
                        @pot += n
                    end
                elsif decision == "call"
                    # Calls the current bet to move forward
                    @pot += player.called(@bet)
                elsif decision == "fold"
                    # Forfeits this hand and all chips in pot
                    player.fold
                end
                if number_of_players == 1
                    return
                end
            end
        end
        return if settled? # Loops until all bets are settled
        option
    end

    def settled? # Verifies all bets are equal or players are all in
        players_in_game.all? { |player| player.players_bet == @bet if player.has_hand? }
    end

    def show_cards # Reveals the cards of the players remaining in the hand at the end
        @players.each do |player|
            puts "#{player.name} has a #{player.hand.rank}" if player.has_hand?
        end
            puts "#{determine_winner.name} has won this hand."
    end

    def new_dealer # Moves the dealer chip and the player under the gun
        new_dealer = @players.shift
        @players.push new_dealer
    end

    def determine_winner # Evaluates each players cards to pick the winner
        return players_in_game.first if number_of_players == 1
        winner = []
        @players.each do |player|
            player.strength_rating
            if winner.empty?
                winner << player
            elsif winner.first.rating < player.rating
                winner.clear
                winner << player
            end
        end
        return winner.first
    end

    def award_pot(player) # Gives all the chips in the pot to a player
        puts "#{player.name} has won #{@pot} chips"
        sleep(5)
        player.award(@pot)
        @pot = 0
    end

    def remove_losers # Removes players who have lost all of their chips
        @players.delete_if { |player| player.chips == 0 }
    end

    def clear_cards # Removes a players cards after the hand is played
        @players.each { |player| player.hand.cards = [] }
    end

    def players_in_game # A list of all players currently in the hand
        @players.select { |player| player.has_hand? }
    end

    def number_of_players # The number of players currently in the hand
        players_in_game.count
    end

    def play # The loop to facilitate game play for each hand until 1 player remains
        until @players.count == 1
            @pot = 0 # Clears the pot
            @bet = 0 # Clears the current bet
            shuffle_cards 
            deal_cards
            antie_up
            # If only 1 player decided to antie up
            if number_of_players == 1
                award_pot(players_in_game.first) 
            else 
                trade_cards # Take player trades
                option # Get player actions until settled
                # If all players but 1 fold during action
                if number_of_players == 1
                    award_pot(players_in_game.first)
                else # All remaining players show cards
                    show_cards
                    # The winner is evaluated and awarded the pot
                    award_pot(determine_winner)
                end
            end
            remove_losers # Players get up from the table if they are out of chips
            clear_cards # Players give cards to dealer
            new_dealer # Dealer chip is moved
        end
    end

end
# A sample game set up with 2 players.
game = Game.new(2)
game.play