


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

    def initialize(cards)
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
            puts "you've got an Ace"
            return :ace_high
        end
        if @values.sort.last < 11
            puts "you've got nothing"
            return :got_nothing
        else 
            if @values.sort.last == 13
                puts "King High"
                return :king_high
            elsif @values.sort.last == 12
                puts "Queen High"
                return :queen_high
            elsif @values.sort.last == 11
                puts "Jack High"
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
            puts 'four of a kind'
            return :four_of_a_kind
        elsif straight_flush?
            puts 'straight flush'
            return :straight_flush
        elsif full_house?
            puts 'full house'
            return :full_house
        elsif flush?
            puts 'flush'
            return :flush
        elsif straight?
            puts 'straight'
            return :straight
        elsif three_of_kind?
            puts 'three of a kind'
            return :three_of_kind
        elsif two_pair?
            puts 'two pair'
            return :two_pair
        elsif pair?
            puts 'pair'
            return :pair
        else
            return high_card
        end
    end

end

# Player
    # Each player has a hand, plus a pot
    # Player has methods to ask the user:
        # Which cards they wish to discard
        # Whether they wish to fold, see, or raise.

class Player

    attr_accessor :hand, :pot

    def initialize(hand, pot)
        @hand, @pot = hand, pot
    end

    def bet
        "Bet?"
        n = gets.chomp.to_i
        @pot -= n
    end

end

# Game
    # Holds the deck
    # Keeps track of whose turn it is
    # Keeps track of the amount in the pot.

class Game

    def initialize

    end

end