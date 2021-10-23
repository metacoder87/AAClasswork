


# Anagrams


# Our goal today is to write a method that determines if two given words 
# are anagrams. This means that the letters in one word can be rearranged 
# to form the other word. 

# For example:
# anagram?("gizmo", "sally")    #=> false
# anagram?("elvis", "lives")    #=> true

# Assume that there is no whitespace or punctuation in the given strings.

# Learning Goals
# Be able to determine the time and space complexity of a method
# Be able to recognize when and how time or space complexity can be improved
# Be able to compare different methods and discuss..
# how changing inputs affects each one's overall runtime

# Phase I:
# Write a method #first_anagram? 
# That will generate and store all the possible anagrams of the first string. 
# Check if the second string is one of these.

# Hints:

# For testing your method, start with small input strings, 
# otherwise you might wait a while. If you're having trouble 
# generating the possible anagrams, look into this method.
# What is the time complexity of this solution? 
        # The time complexity of first_anagram? is O(n!)
# What happens if you increase the size of the strings?
        # With larger strings the methods ability to generate 
        # all possible permutations gets exponentially slower.

        # Takes str1, the first string, and splits it into and array
        # Then it generates all possible permutations 
        # Last it checks to see if any permutations match the second string
        # O(1) Space
        # 0(n!) Time
    def first_anagram?(str1, str2) 
        str1.split('').permutation(str1.length).any? do |str|
            str.join('') == str2
        end
    end

    puts first_anagram?("gizmo", "sally")    #=> false
    puts first_anagram?("elvis", "lives")    #=> true
    puts first_anagram?("cat", "act") # => true
    puts first_anagram?("theeyes", "theysee") # => true
    puts first_anagram?("blue", "clue") # => false
    # Commented out these last tests because they take a few minutes each test
    # puts first_anagram?("hippopotamus", "hippo") # => false
    # puts first_anagram?("twelveplusone", "elevenplustwo") # => true



# Phase II:
# Write a method #second_anagram? 
# That iterates over the first string.
# For each letter in the first string, find the index of 
# that letter in the second string (hint: use Array#find_index)
# and delete at that index. The two strings are anagrams if an 
# index is found for every letter and the second string is 
# empty at the end of the iteration.

    def second_anagram?(str1, str2) # => O(n)
        str1.split("").each do |char|
            str2 = str2.split("")
            if str2.index(char)
                str2.delete_at(str2.index(char))
                str2 = str2.join("")
            else return false
            end
        end
        return true if str2.empty?
    end

# Try varying the length of the input strings. 
# What are the differences between #first_anagram? and #second_anagram??
        # The main difference is that second_anagram? runs in linear time 
        # Making it way faster and capable of computing larger strings
        # in a reasonable amount of time

        # first_anagram? must first generate all the possible permutations 
        # the possible permutations grow exponentially with the size of the 
        # string making first_anagram? unsuitable for checking large strings

    puts second_anagram?("gizmo", "sally")    #=> false
    puts second_anagram?("elvis", "lives")    #=> true
    puts second_anagram?("b", "c") # => false
    puts second_anagram?("i", "i") # => true
    puts second_anagram?("to", "it") # => false
    puts second_anagram?("ok", "ko") # => true
    puts second_anagram?("bee", "see") # => false
    puts second_anagram?("cat", "act") # => true
    puts second_anagram?("blue", "clue") # => false
    puts second_anagram?("know", "wonk") # => true
    puts second_anagram?("phone", "penot") # => false
    puts second_anagram?("theeyes", "theysee") # => true
    puts second_anagram?("hippopotamus", "hippo") # => false
    puts second_anagram?("twelveplusone", "elevenplustwo") # => true
    puts second_anagram?("notananagramer", "butyougettheidea") # => false
    puts second_anagram?("electionresults", "liesletsrecount") # => true
    puts "All tests have finished"


# Phase III:
# Write a method #third_anagram? 
# That solves the problem by sorting both strings alphabetically. 
# The strings are then anagrams if and only if the sorted versions 
# are the identical.

# What is the time complexity of this solution? 
# Is it better or worse than #second_anagram??

# Phase IV:
# Write one more method #fourth_anagram?. 
# This time, use two Hashes to store the number of 
# times each letter appears in both words. Compare the resulting hashes.

# What is the time complexity?

# Bonus: Do it with only one hash.

# Discuss the time complexity of your solutions together, 
# then call over your TA to look at them.