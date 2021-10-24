


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
    puts "All first_anagram? tests have finished"



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
    puts "All second_anagram? tests have finished"


# Phase III:
# Write a method #third_anagram? 
# That solves the problem by sorting both strings alphabetically. 
# The strings are then anagrams if and only if the sorted versions 
# are the identical.

# What is the time complexity of this solution? 
# Is it better or worse than #second_anagram??
    # The time complexity of this solution is going to O(n log(n))
    # Because that is the best sorting complexity merge_sort
    # O(n log(n)) is not as good as O(n)
    # third_anagram? is worse than second_anagram? but still effective

    def third_anagram?(str1, str2) # => O(n log(n))
        merge_sort(str1.split("")) == merge_sort(str2.split(""))
    end

        # Merge Sort: O(n*lg(n))

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
        prc = Proc.new { |char1, char2| char1 <=> char2 } unless block_given?
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

    puts third_anagram?("gizmo", "sally")    #=> false
    puts third_anagram?("elvis", "lives")    #=> true
    puts third_anagram?("b", "c") # => false
    puts third_anagram?("i", "i") # => true
    puts third_anagram?("to", "it") # => false
    puts third_anagram?("ok", "ko") # => true
    puts third_anagram?("bee", "see") # => false
    puts third_anagram?("cat", "act") # => true
    puts third_anagram?("blue", "clue") # => false
    puts third_anagram?("know", "wonk") # => true
    puts third_anagram?("phone", "penot") # => false
    puts third_anagram?("theeyes", "theysee") # => true
    puts third_anagram?("hippopotamus", "hippo") # => false
    puts third_anagram?("twelveplusone", "elevenplustwo") # => true
    puts third_anagram?("notananagramer", "butyougettheidea") # => false
    puts third_anagram?("electionresults", "liesletsrecount") # => true
    puts "All third_anagram? tests have finished"

# Phase IV:
# Write one more method #fourth_anagram?. 
# This time, use two Hashes to store the number of 
# times each letter appears in both words. Compare the resulting hashes.

    def fourth_anagram?(str1, str2) # => O(n)
        hash1 = {}
        str1.each_char do |char|
            if hash1[char]
                hash1[char] += 1
            else hash1[char] = 1
            end
        end
        hash2 = {}
        str2.each_char do |char|
            if hash2[char]
                hash2[char] += 1
            else hash2[char] = 1
            end
        end
        return hash1 == hash2
    end

    puts fourth_anagram?("gizmo", "sally")    #=> false
    puts fourth_anagram?("elvis", "lives")    #=> true
    puts fourth_anagram?("b", "c") # => false
    puts fourth_anagram?("i", "i") # => true
    puts fourth_anagram?("to", "it") # => false
    puts fourth_anagram?("ok", "ko") # => true
    puts fourth_anagram?("bee", "see") # => false
    puts fourth_anagram?("cat", "act") # => true
    puts fourth_anagram?("blue", "clue") # => false
    puts fourth_anagram?("know", "wonk") # => true
    puts fourth_anagram?("phone", "penot") # => false
    puts fourth_anagram?("theeyes", "theysee") # => true
    puts fourth_anagram?("hippopotamus", "hippo") # => false
    puts fourth_anagram?("twelveplusone", "elevenplustwo") # => true
    puts fourth_anagram?("notananagramer", "butyougettheidea") # => false
    puts fourth_anagram?("electionresults", "liesletsrecount") # => true
    puts "All fourth_anagram? tests have finished"

# What is the time complexity?

# Bonus: Do it with only one hash.

# Discuss the time complexity of your solutions together, 
# then call over your TA to look at them.