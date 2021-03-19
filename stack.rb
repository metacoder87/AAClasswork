class Stack


    def initialize
        @ivar = [] # create ivar to store stack here!
    end

    def push(el)
      @ivar.push(el)# adds an element to the stack
    end

    def pop
      @ivar.shift # removes one element from the stack
    end

    def peek
      @ivar.first # returns, but doesn't remove, the top element in the stack
    end
  end