# First TDD Projects

# ⏱ 2 hours

# Test Driven Development

# Learning Goals

# Be able to explain what functionality your testing will cover
# Know the hierarchy / syntax of RSpec methods 
# (describe, before, let, it, expect, etc.)
# Be comfortable writing RSpec tests
# Know when to use let and subject

# Expected time: 2hrs

# Do all of the following exercises TDD. That means writing specs first!

# When approaching each problem, make sure to:

# Read the entire problem statement.
# Talk with your partner to identify test cases 
# and key functionality to expect from your code.
# Write RSpec tests.
# Write the method you now have tests for. 
# Follow the red-green-refactor approach until all specs pass.

class Array
# Remove dups

# Array has a uniq method that removes duplicates from an array. 
# It returns the unique elements in the order in which they first appeared:

# [1, 2, 1, 3, 3].uniq # => [1, 2, 3]
# Write your own version of this method called my_uniq; 
# it should take in an Array and return a new array.

    def my_uniq # f(n) = 0(n)
        # This array is a store for one of each of the elements of self
        one_of_each = []
        # This iterates through each of the elements and saves that element if it hasn't already
        self.each { |ele| one_of_each.include?(ele) ? next : one_of_each << ele }
        return one_of_each
    end


# Two sum

# Write a new Array#two_sum method that finds all pairs of 
# positions where the elements at those positions sum to zero.

# NB: ordering matters. 
# We want each of the pairs to be sorted smaller index before bigger index. 
# We want the array of pairs to be sorted "dictionary-wise":

# [-1, 0, 2, -2, 1].two_sum # => [[0, 4], [2, 3]]
# [0, 2] before [2, 1] (smaller first elements come first)
# [0, 1] before [0, 2] (then smaller second elements come first)

    def two_sum # This solution is in linear 0(n) time
        # This array is a place to hold the pairs of indices 
        indices = []
        # Iterates through each element
        self.each_with_index do |ele, idx|
            # Creates the inverse of element that will sum to zero
            opposite = ele * - 1
            # Saves the index of that number if it exists in self
            opp_idx = self.index(opposite) if self.include?(opposite)
            # Shovels the index of the original element and its opposite into indices array once if the two are not equal 
            indices << [idx, opp_idx].sort if opp_idx && !indices.include?([idx, opp_idx].sort) && idx != opp_idx
        end
        # outputs an array of sorted indices
      return indices.sort
    end

end

# My Transpose

# To represent a matrix, or two-dimensional grid of numbers, 
# we can write an array containing arrays which represent rows:

# rows = [
#     [0, 1, 2],
#     [3, 4, 5],
#     [6, 7, 8]
#   ]

# row1 = rows[0]
# row2 = rows[1]
# row3 = rows[2]
# We could equivalently have stored the matrix as an array of columns:

# cols = [
#     [0, 3, 6],
#     [1, 4, 7],
#     [2, 5, 8]
#   ]

# Write a method, my_transpose, which will convert between 
# the row-oriented and column-oriented representations. 
# You may assume square matrices for simplicity's sake. 
# Usage will look like the following:

# my_transpose([
#     [0, 1, 2],
#     [3, 4, 5],
#     [6, 7, 8]
#   ])
#  # => [[0, 3, 6],
#  #    [1, 4, 7],
#  #    [2, 5, 8]]

    def my_transpose(arr) # This solution is in Quadratic time f(n) = 0(n^2)
        # This array will house the transposition of the given array
        converse = []
        # This variable is the index which will be transposed each loop
        i = 0
        # This loop will run until i is equal with the number of elements in the sub-arrays
        until i == arr.first.count
            # This array will save each transposed element
            new_sub = []
            # This iterates through the sub-arrays and shovels the element at the specified index
            arr.each { |sub| new_sub << sub[i] }
            # This shovels the newly created sub-array into converse
            converse << new_sub
            # This increases the index for the next new sub-array
            i += 1
        end

        return converse
    end


# Stock Picker

# Write a method that takes an array of stock prices (prices on days 0, 1, ...), 
# and outputs the most profitable pair of days on which to first buy the stock 
# and then sell the stock. Remember, you can't sell stock before you buy it!
class Array
    def stock_picker # Solution in quadratic time f(n) = 0(n^2)
        # This array houses the best pick
        pick = []
        # This variable keeps track of the day/index we are looking at as the best potential buy 
        i = 0
        # This keeps track of the most profit from all of the potential trades
        profit = 0
        # Loops until is equal with the last index
        until i == self.count - 1
            # Iterates through each price
            self.each_with_index do |price, idx|
                # Checks if i is less than current index and if this potential profit is the new highest
                if i < idx && profit < self[idx] - self[i]
                    # Saves a new highest profit
                    profit = self[idx] - self[i]
                    # Saves a new best pick
                    pick = [i, idx]
                end
            end
            i += 1
        end
        return pick
    end
end


# Towers of Hanoi

# Write a Towers of Hanoi game.
# Keep three arrays, which represents the piles of discs. 
# Pick a representation of the discs to store in the arrays; 
# maybe just a number representing their size. 
# Don't worry too much about making the user interface pretty.
# In a loop, prompt the user (using gets) and ask what pile 
# to select a disc from, and where to put it.
# After each move, check to see if they have succeeded in moving all 
# the discs, to the final pile. If so, they win!

# Note: don't worry about testing the UI. 
# Testing console I/O is tricky (don't bother checking gets or puts). 

# Focus on:
# #move
# #won?

# Creates a class for the Towers of Hanoi game
class HanoiTowers
    # Allows access to instance variable
    attr_accessor :pile1, :pile2, :pile3
    # Takes in a number and sets the 3 piles
    def initialize(n)
        @pile1 = []
        @pile2 = []
        @pile3 = []
        # Fills the first pile with the number of discs given
        (1..n).each { |disc| @pile1.unshift disc }
    end

    def get_pile # Gets user input for a draw pile
        # User instructions
        puts "Choose a pile to draw from..."
        # Gets user input
        pile = gets.chomp.to_i
        # Returns the pile corresponding to the user input 
        # or asks again if not given 1,2, or 3
        if pile == 1
            return @pile1
        elsif pile == 2
            return @pile2
        elsif pile == 3 
            return @pile3
        else get_pile
        end
    end

    def get_destination # Gets user input about where to place the drawn disc
        # User instructions
        puts "Choose a place to put the disc..."
        # Gets the user input
        choice = gets.chomp.to_i
        # Returns the pile corresponding to the user input
        # if the given piles top disc is larger than the one drawn
        # or asks again if not given 1,2, or 3
        if choice == 1
            if @pile1.empty? || @pile1.last > @pile.last
                return @pile1
            else get_destination
            end
        elsif choice == 2
            if @pile2.empty? || @pile2.last > @pile.last
                return @pile2
            else get_destination
            end
        elsif choice == 3 
            if @pile3.empty? || @pile3.last > @pile.last
                return @pile3
            else get_destination
            end
        else get_destination
        end
    end

    def move
        # Chooses a disc pile from which to draw
        @pile = get_pile
        # Chooses a disc pile to place that disc
        choice = get_destination
        # Picks up the disc and moves it to chosen pile
        choice << @pile.pop
    end

    def won? # Checks if all of the discs have moved to the third pile
        if @pile1.empty? && @pile2.empty?
            puts 'Congrats you have defeated the Towers of Hanoi!'
            return true
        end
        return false
    end

    def display # Outputs the board
        i = 1 # User input requested
        # An array of the piles
        arr = [@pile1, @pile2, @pile3]
        # Iterates throught the array
        arr.each do |pile| 
            # Outputs the input request with it's associated pile
            print " #{i} = #{pile} "
            # Increases the input request for the next pile
            i += 1
        end
    end

    def play # Loops game-play until game is won
        until won? # Checks if the game is won
            display # Outputs the board
            move # Moves another disc
        end
    end

end

# Comment this out if you do not want the game to run automatically
# or change the input to a higher number to increase difficulty of game-play
ht = HanoiTowers.new(3) # Creates a new game with three discs
ht.play # Runs the Towers of Hanoi game


# Get a code review from a TA
# Resources