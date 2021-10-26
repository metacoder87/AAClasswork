require 'benchmark'


    # Execution Time Difference
        
        # Learning Goals
            # Be able to determine the time and space complexity of a method
            # Be able to compare the time complexity of one method to another
            # Be able to recognize when time or space complexity can be improved

        # my_min
            # Given a list of integers find the smallest number in the list.

        # Example:

            #     list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
            #     my_min(list)  # =>  -5


    # Phase I

        # First, write a function that compares each
        # element to every other element of the list. 
        # Return the element if all other elements in the array are larger.
        # What is the time complexity for this function?
                # O(n^2) time complexity to compare each element to each element.

                def my_min_slow(arr) # O(n^2)
                    arr.each do |ele|
                        return ele if arr.all? { |num| ele <= num }
                    end
                end
list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
puts my_min_slow(list)  # =>  -5
puts Benchmark.measure { my_min_slow(list) }

    # Phase II

        # Now rewrite the function to iterate through the 
        # list just once while keeping track of the minimum. 
        # What is the time complexity?
                # O(n) time complexity to iterate through a list once.

                def my_min_lin(arr) # O(n)
                    mini = arr.first 
                    arr.each { |num| mini = num if num < mini }
                    return mini
                end
puts my_min_lin(list)  # =>  -5
puts Benchmark.measure { my_min_lin(list) }

        # Largest Contiguous Sub-sum
            # You have an array of integers and you want to find the 
            # largest contiguous (together in sequence) sub-sum. 
            # Find the sums of all contiguous sub-arrays and return the max.

        # Example 1:

            #     list = [5, 3, -7]
            #     largest_contiguous_subsum(list) # => 8

            #     # possible sub-sums
            #     [5]           # => 5
            #     [5, 3]        # => 8 --> we want this one
            #     [5, 3, -7]    # => 1
            #     [3]           # => 3
            #     [3, -7]       # => -4
            #     [-7]          # => -7

        # Example 2:

            #     list = [2, 3, -6, 7, -6, 7]
            #     largest_contiguous_subsum(list) # => 8 (from [7, -6, 7])

        # Example 3:

            #     list = [-5, -1, -3]
            #     largest_contiguous_subsum(list) # => -1 (from [-1])


    # Phase I

        # Write a function that iterates through the array
        # and finds all sub-arrays using nested loops. 
        # First make an array to hold all sub-arrays. 
        # Then find the sums of each sub-array and return the max.

        # Discuss the time complexity of this solution.

                # This method uses a linear iteration with two nested loops 
                # also with linear time complexities so it has an
                # O(n^2) 
                

            def largest_contiguous_subsum_slow(arr) # O(n^2)
                largest = -999999999999999999
                arr.each_with_index do |num, idx| # O(n)

                    (idx...arr.count).to_a.each do |i| # O(n)
                        sub_sum = arr[idx..i].inject(:+)
                        largest = sub_sum if sub_sum > largest 
                    end
                end

                return largest
            end

    # Phase II

        # Let's make a better version. 
        # Write a new function using O(n) time with O(1) memory. 
        # Keep a running tally of the largest sum. 
        # To accomplish this efficient space complexity,
        # consider using two variables. 
        # One variable should track the largest sum
        # so far and another to track the current sum. 
        # We'll leave the rest to you.

            # I had to peak at the solution to fix this one on this last commit.
            def largest_contiguous_subsum_linear(arr) # O(n)
                largest = arr.first
                current = arr.first
                (1...arr.length).each do |idx|
                    current = 0 if current < 0
                    current += arr[idx] 
                    largest = current if current > largest
                end
                return largest
            end
                        
                    

        # Get your story straight, and then explain
        # your solution's time complexity to your TA.

list = [5, 3, -7]
puts largest_contiguous_subsum_slow(list) # => 8
puts largest_contiguous_subsum_linear(list) # => 8
puts Benchmark.measure { largest_contiguous_subsum_slow(list) }
puts Benchmark.measure { largest_contiguous_subsum_linear(list) }

list = [2, 3, -6, 7, -6, 7]
puts largest_contiguous_subsum_slow(list) # => 8
puts largest_contiguous_subsum_linear(list) # => 8
puts Benchmark.measure { largest_contiguous_subsum_slow(list) }
puts Benchmark.measure { largest_contiguous_subsum_linear(list) }

list = [-5, -1, -3]
puts largest_contiguous_subsum_slow(list) # => -1
puts largest_contiguous_subsum_linear(list) # => -1
puts Benchmark.measure { largest_contiguous_subsum_slow(list) }
puts Benchmark.measure { largest_contiguous_subsum_linear(list) }