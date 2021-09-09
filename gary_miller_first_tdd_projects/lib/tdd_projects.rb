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

    def two_sum
        # This array is a place to hold the pairs of indices 
        indices = []
        # Sets a pointer at the start of the array
        comp_index = 0
        # Sets another pointer at the end of the array
        comp_index2 = self.count - 1
        # loops until the pointers meet in the middle
        until comp_index == self.count / 2
            # iterates through each element to compare with the elements at each pointer
            self.each_with_index do |ele, idx|
                # checks the current element against the first pointer
                if self[comp_index] + ele == 0 # if the sum of these two elements is equal to zero
                    # verifies the indices does not already contain this pair
                    if !indices.include?([comp_index, idx]) && !indices.include?([idx, comp_index])
                        # verifies the pointer is not on the current element and shovels the sorted pair of indices into indices
                        indices << [comp_index, idx].sort if idx != comp_index
                    end
                # checks the current element against the second pointer
                elsif self[comp_index2] + ele == 0 # if the sum of these two elements is equal to zero
                    # verifies the indices does not already contain this pair
                    if !indices.include?([comp_index2, idx]) && !indices.include?([idx, comp_index2])
                        # verifies the pointer is not on the current element and shovels the sorted pair of indices into indices
                        indices << [comp_index2, idx].sort if idx != comp_index2
                    end
                end
            end
            # moves the pointers towards the center
          comp_index += 1
          comp_index2 -= 1
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

    def my_transpose

    end


# Stock Picker

# Write a method that takes an array of stock prices (prices on days 0, 1, ...), 
# and outputs the most profitable pair of days on which to first buy the stock 
# and then sell the stock. Remember, you can't sell stock before you buy it!

    def stock_picker

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

class HanoiTowers

    def self.get_discs

    end

    def initialize
    
    end

    def get_pile

    end

    def get_destination

    end

    def move

    end

    def won?

    end

    def print

    end

    def play

    end

end


# Get a code review from a TA
# Resources