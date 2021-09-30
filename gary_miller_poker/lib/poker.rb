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

class Card

    attr_reader :suit, :value

    def initialize(suit, value)
        @suit, @value = suit, value
    end

end

# Deck

class Deck

    attr_reader :cards

    def initialize
        @cards = deck_builder
    end

    def value_array
        base_vals = [2,3,4,5,6,7,8,9,10]
        face_vals = [:Jack,:Queen,:King,:Ace]
        return base_vals + face_vals
    end

    def suit_hasher
        suits = [:hearts,:clubs,:diamonds,:spaids]
        cards = {}
        suits.each do |suit|
            cards[suit] = []
        end
        return cards
    end

    def deck_builder
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
        @cards = cards
        @values = []
    end

    def sort_vals
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

    def card_count
        cnt = {}
        @cards.each { |card| cnt[card.value] = 0 }
        @cards.each { |card| cnt[card.value] += 1 }
        return cnt
    end

    def high_card
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


    def pair?
        card_count.any? { |card, count| count == 2 }
    end

    def two_pair?
        card_count.select { |card, count| count == 2 }.count == 2
    end

    def three_of_kind?
        card_count.any? { |card, count| count == 3 }
    end

    def straight?
        @values.sort[-1] - @values.sort[0] == 4
    end

    def flush?
        @cards.all? { |card| card.suit == @cards[0].suit }
    end

    def full_house?
        return three_of_kind? && pair?
    end

    def straight_flush?
        return straight? && flush?
    end

    def four_of_a_kind?
        card_count.any? { |card, count| count == 4 }
    end

    def rank
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

    def weight
        if rank == :pair
            return 15
        elsif rank == :two_pair
            return 16
        elsif rank == :three_of_kind
            return 17
        elsif rank == :straight
            return 18
        elsif rank == :flush
            return 19
        elsif rank == :full_house
            return 20
        elsif rank == :straight_flush
            return 21
        elsif rank == :four_of_a_kind
            return 22
        elsif high_card == :ace_high
            return 14
        elsif high_card == :king_high
            return 13
        elsif high_card == :queen_high
            return 12
        elsif high_card == :jack_high
            return 11
        else return high_card
        end
    end

end

# Player
    # Each player has a hand, plus a pot
    # Player has methods to ask the user:
        # Which cards they wish to discard
        # Whether they wish to fold, see, or raise.

class Player

    attr_accessor :hand, :chips, :players_bet, :rating 

    def initialize(chips)
        @chips, @hand, @players_bet = chips, Hand.new, 0
    end

    def see_hand
        c = []
        @hand.cards.each do |card|
            if card.suit == :hearts
                c << [card.value,:H]
            elsif card.suit == :spaids
                c << [card.value,:S]
            elsif card.suit == :diamonds
                c << [card.value,:D]
            else c << [card.value,:C]
            end
        end
        c.each { |card| print card }
    end

    def fold
        @hand.cards = []
    end

    def has_hand?
        return false if @hand.cards.empty?
        return true
    end

    def antie_up?
        system 'clear'
        see_hand
        puts @hand.rank
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

    def trade?
        system 'clear'
        puts "You can trade up to 3 cards..."
        puts "Don't want to trade? Press ENTER"
        puts "Enter cards in format, 3H, AD, 10S"
        puts "3 of Hearts as 3H, Ace of Diamonds as AD"
        see_hand
        puts "\n"
        trades = gets.chomp.to_s.split(",")
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

    def action?(current_bet)
        @bet = 0
        system 'clear'
        puts "Would you like to..."
        if current_bet == 0
            puts "fold, check, or bet?"
        elsif current_bet > 0
            puts "fold, call, or raise?"
            puts "Current bet is #{current_bet}"
        end
        see_hand
        response = gets.chomp.to_s
        if response == "fold"
            fold
            return response
        elsif response == "check"
            return response
        elsif response == "bet"
            return response
        elsif response == "call"
            return response
        elsif response == "raise"
            return response
        else action?
        end
    end


    def bet(min)
        system 'clear'
        puts "What would you like to bet from #{min} to #{@chips}?"
        @players_bet = gets.chomp.to_i
        if (min..@chips).include?(@players_bet)
            @chips -= @players_bet
            return @players_bet
        else bet(min)
        end
    end

    def called(current_bet)
        @chips -= current_bet
    end

    def strength_rating
        @rating = @hand.weight
    end

    def award(pot)
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
        @players = []
        @deck = Deck.new
        make_players(num_players)
        @pot = 0
        @bet = 0 
    end

    def make_players(n)
        until n == 0
            @players << Player.new(1500)
            n -= 1
        end
    end

    def shuffle_cards
        @cards = @deck.cards.values.flatten.shuffle
    end

    def deal_cards
        @players.each { |player| player.hand.cards = @cards.pop(5) }
    end

    def antie_up
        @players.each do |player| 
            if player.antie_up?
                if player.chips >= 15
                    player.chips -= 15
                    @pot += 15
                elsif player.chips < 15
                    @pot += player.chips
                    player.chips = 0
                end
            end
        end
    end

    def trade_cards
        @players.each do |player|
            trades = player.trade?
            player.hand.cards.push @cards.pop trades if trades > 0
            player.hand.cards.flatten!
            puts "Your new hand is..."
            player.see_hand
            sleep(5)
        end
    end

    def option
        @players.each do |player|
            decision = player.action?(@bet)
            if decision == "check" || decision == "fold"
                next
            elsif decision == "bet" || decision == "raise"
                n = player.bet(@bet)
                @bet = n if n > @bet
                @pot += n
            elsif decision == "call"
                player.called(@bet)
                @pot += @bet
                next
            else option
            end
        end
        option unless settled?
    end

    def settled?
        @players.all? { |player| player.players_bet == @bet if player.has_hand? }
    end

    def show_cards
        @players.each do |player|
            puts "#{player} has a #{player.hand.rank}" if player.has_hand?
        end
            puts "#{determine_winner} has won this hand."
    end

    def new_dealer
        new_dealer = @players.shift
        @players.push new_dealer
    end

    def determine_winner
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

    def award_pot(player)
        puts "#{determine_winner} has won #{@pot} chips"
        sleep(3)
        player.award(@pot)
        @pot = 0
    end

    def remove_losers
        @players.delete_if { |player| player.chips == 0 }
    end

    def clear_cards
        @players.each { |player| player.hand = [] }
    end

    def players_in_game
        @players.select { |player| player.has_hand? }
    end

    def number_of_players
        players_in_game.count
    end

    def play
        while @players.count > 1 do
            @bet = 0
            shuffle_cards
            deal_cards
            antie_up

            while number_of_players > 1 do
                trade_cards
                option 
                show_cards
                award_pot(determine_winner)
                remove_losers
                clear_cards
                new_dealer
            end
            award_pot(players_in_game.first)
        end
    end

end

game = Game.new(2)
game.play