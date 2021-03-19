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
