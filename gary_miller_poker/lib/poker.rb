


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

    def initialize(suit, value)

    end

end

# Deck

class Deck

    def initialize

    end

end

    # Request a TA Code review

# Hand
    # The logic of calculating pair, three-of-a-kind, two-pair, etc. goes here.
    # Logic of which hand beats which would go here.

class Hand

    def initialize

    end

end

# Player
    # Each player has a hand, plus a pot
    # Player has methods to ask the user:
        # Which cards they wish to discard
        # Whether they wish to fold, see, or raise.

class Player

    def initialize

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