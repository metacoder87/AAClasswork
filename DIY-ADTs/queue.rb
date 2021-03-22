            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/AAClasswork


class Queue
    #FIFO

    attr_reader :q

    def initialize
        @q = []
    end

    def enqueue(el)
        @q.push(el)
    end
    
    def dequeue
        @q.shift
    end
    
    def peek
        @q.first
    end

end