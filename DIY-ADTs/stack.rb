            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/AAClasswork



class Stack
    #LIFO


    def initialize
        @ivar = [] # create ivar to store stack here!
    end

    def push(el)
      @ivar.push(el)# adds an element to the stack
    end

    def pop
      @ivar.pop # removes one element from the stack
    end

    def peek
      @ivar.last # returns, but doesn't remove, the top element in the stack
    end

  end


            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/AAClasswork