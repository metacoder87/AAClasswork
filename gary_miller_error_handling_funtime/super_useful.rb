# PHASE 2
def convert_to_int(str)
  num_arr = str.split(" ")
  if num_arr.count == 1
    return num_word(num_arr.first)
  elsif num_arr.count == 2
    return num_arr.map! { |word| word == num_arr.first ? dub_num_word(word) : num_word(word) }.join.to_i
  else   
    return "That there number is too big for me. I would have to take off my shoes to count that high, but I forgot to bring my feet to work today."
  end
end

def num_word(word)
  case word
  when "zero"
    0
  when "one"
    1
  when "two"
    2
  when "three"
    3
  when "four"
    4
  when "five"
    5
  when "six"
    6
  when "seven"
    7
  when "eight"
    8
  when "nine"
    9
  when "ten"
    10
  when "twenty"
    20
  when "thirty"
    30 
  when "forty"
    40
  when "fifty"
    50
  when "sixty"
    60
  when "seventy"
    70
  when "eighty"
    80
  when "ninety"
    90
  else "That is not a number"
  end
end

def dub_num_word(word)
  case word
  when "twenty"
    2 
  when "thirty"
    3 
  when "forty"
    4
  when "fifty"
    5 
  when "sixty"
    6 
  when "seventy"
    7
  when "eighty"
    8
  when "ninety"
    9
  end
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  unless FRUITS.include? maybe_fruit
    raise ArgumentError.new "That's not a fruit I like."
  else 
    return "OMG, thanks so much for the #{maybe_fruit}!"
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"
  puts "Feed me a fruit! (Enter the name of a fruit:)"
  maybe_fruit = gets.chomp.downcase
  reaction(maybe_fruit)
  rescue ArgumentError
    if maybe_fruit == "coffee"
      puts "I love coffee, but it ain't fruit!"
      retry 
    else puts "I asked for fruit and you give me, #{maybe_fruit}. I quit"
      return
    end
end 

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
      raise ArgumentError.new "Best friends know each others names." unless @name.length > 0
    @yrs_known = yrs_known
      raise ArgumentError.new "Friendships need to mature for at least 5 years before they can be BEST friends." unless @yrs_known > 4
    @fav_pastime = fav_pastime
      raise ArgumentError.new "Best friends do things together." unless @fav_pastime.length > 0
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


