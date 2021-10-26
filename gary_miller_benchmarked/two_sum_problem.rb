require 'benchmark'


# two_sum?

# Given an array of unique integers and a target sum, determine 
# whether any two integers in the array sum to that amount.

# def two_sum?(arr, target_sum)
#     # your code here...
# end

# arr = [0, 1, 5, 7]
# two_sum?(arr, 6) # => should be true
# two_sum?(arr, 10) # => should be false
# Learning Goals
# Be able to reason about a difficult problem and think of ways to solve it.
# Be able to determine and explain the time and space complexity of a method
# Be able to recognize when time or space complexity can be improved
# Know some common tricks to improve time or space complexity
# Before you start coding anything, talk it over with your partner. 
# Sketch out on paper how you'd approach this problem. 
# What would be the running time of your proposed solution? 
# Take as long as you need, but don't write any code yet.


# Brute force
# If we weren't worried about time complexity, what would be the most 
# straightforward way to solve this problem? To start with, we could 
# check every possible pair. If we sum each element with every other, 
# we're sure to either find the pair that sums to the target, or 
# determine that no such pair exists.

# This is the brute force solution. It's essentially hitting the problem 
# with a sledge hammer. There are faster and more elegant ways to solve 
# the problem, but we know for sure that this will get the job done.

# Let's start by implementing the brute force solution. 
# Write a method called bad_two_sum?, which checks every possible pair.

# Make sure that you don't pair an element with itself. 
# However, you don't need to bother checking for summing 
# the same pair twice; that won't affect your result.

# (Note: you can cut the running-time significantly by returning early, 
# and by not checking pairs more than once. However, these micro-optimizations
# will not improve the time complexity of the solution. Do you see why?)

# Once you're done, write a comment with your solution's time complexity.

    def bad_two_sum?(arr, target) # => O(n^2) Quadratic Time
        bad_sums = {}
        arr.each_with_index do |num1, idx|
            arr.each_with_index do |num2, i|
                if bad_sums[num1] && bad_sums[num1].include?(num2)
                    next
                elsif bad_sums[num2] && bad_sums[num2].include?(num1)
                    next
                else
                    if num1 + num2 == target
                        return true unless idx == i
                    else
                        if bad_sums[num1]
                            
                        else bad_sums[num1] = []
                        end
                        bad_sums[num1] << num2
                    end
                end
            end
        end
        return false
    end

arr = [0, 1, 5, 7]
long_array = (0..1000).to_a.shuffle.drop(50)
puts bad_two_sum?(arr, 6) # => should be true
puts bad_two_sum?(arr, 10) # => should be false
puts bad_two_sum?(long_array, 1257) # => true
puts Benchmark.measure { bad_two_sum?(arr, 10) }
puts Benchmark.measure { bad_two_sum?(long_array, 1257) }
# puts bad_two_sum?(long_array, 5040) # => false
puts "Finished running bad_two_sum? tests"

# Sorting
# As a person of elevated algorithmic sensibilities, 
# the brute-force approach is beneath you. 
# Leave that nonsense to the riffraff. 
# Instead, you'll apply a refined and time-honored technique: sorting.

# Sort your data, then try to solve the problem.

# What does sorting do to the lower bound of your time complexity?
    # By sorting before searching the lower bound is reduced from O(n^2) to O(n*log(n))

# How might sorting that make the problem easier?
    # Sorting makes the problem much easier by opening up cheap
    # algorithms like bsearch with O(log(n)) to quickly search the array

# Write a second solution, called okay_two_sum?, which uses sorting. 
# Make sure it works correctly.

   # Merge Sort: O(n*lg(n))
    def merge_sort (array, &prc)
        return array if array.length <= 1

        mid_idx = array.length / 2
        merge(
            merge_sort(array.take(mid_idx), &prc),
            merge_sort(array.drop(mid_idx), &prc),
            &prc
            )
    end

    # NB: In Ruby, shift is an O(1) operation. This is not true of all languages.
    def merge(left, right, &prc)
        merged_array = []
        prc = Proc.new { |num1, num2| num1 <=> num2 } unless block_given?
        until left.empty? || right.empty?
            case prc.call(left.first, right.first)
                when -1
                    merged_array << left.shift
                when 0
                    merged_array << left.shift
                when 1
                    merged_array << right.shift
            end
        end

        merged_array + left + right
    end

# Hint: (There are a couple ways to solve this problem once it's sorted. 
# One way involves using a very cheap algorithm that can only be used 
# on sorted data sets. What are some such algorithms you know?)

    def okay_two_sum?(arr, target) # => O(n*log(n))
        merge_sort(arr).bsearch do |ele|
            if arr.include?(target - ele)
                if target / 2 == ele
                    if arr.index(ele) != arr.rindex(ele)
                        return true
                    end
                else return true
                end
            end
        end
        return false
    end

puts okay_two_sum?(arr, 6) # => should be true
puts okay_two_sum?(arr, 10) # => should be false
puts okay_two_sum?(arr, 8) # => true
puts okay_two_sum?(long_array, 2218) # => false
puts okay_two_sum?(long_array, 1257) # => true
puts okay_two_sum?(long_array, 5040) # => false
puts Benchmark.measure { okay_two_sum?(arr, 8) }
puts Benchmark.measure { okay_two_sum?(long_array, 1257) }
puts "Finished running okay_two_sum? tests"

# Hash Map
# Finally, it's time to bust out the big guns: a hash map. 
# Remember, a hash map has O(1) #set and O(1) #get, so you can build 
# a hash out of each of the n elements in your array in O(n) time. 
# That hash map prevents you from having to repeatedly find values 
# in the array; now you can just look them up instantly.

# See if you can solve the two_sum? problem 
# in linear time now, using your hash map.

    def two_sum?(arr, target) # => O(n)
        hash = {}
        arr.each do |num| 
            found = hash[target - num]
            return true if found
            hash[num] = target - num
        end
        return false
    end

puts two_sum?(arr, 6) # => should be true
puts two_sum?(arr, 10) # => should be false
puts two_sum?(arr, 8) # => true
puts two_sum?(long_array, 2218) # => false
puts two_sum?(long_array, 1257) # => true
puts two_sum?(long_array, 5040) # => false
puts Benchmark.measure { two_sum?(arr, 8) }
puts Benchmark.measure { two_sum?(long_array, 1257) }
puts "Finished running two_sum? tests"

# Once you're finished, make sure you understand the time complexity of 
# your solutions and then call over your TA and show them what you've got. 
# Defend to them why each of your solutions
# has the time complexity you claim it does.

# Bonus (come back to this once you have completed windowed max range exercises)
# See if you can extend your solution of two_sum? to solve four_sum?