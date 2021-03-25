            # meta_coder (Gary Miller) =)
            # gmiller052611@gmail.com
            # https://github.com/metacoder87/AAClasswork
            
            
class PolyTreeNode

    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(new_parent)
        unless new_parent
            return @parent = nil
        else 
            @parent.children.delete_if { |child| child == self } if @parent
            new_parent.children << self if !new_parent.children.include?(self)
            @parent = new_parent
        end
    end

    def add_child(child)
        @children << child unless @children.include?(child)
        child.parent=(self)
    end

    def remove_child(child)
        raise if !child.parent.children.include?(child)
        child.parent.children.delete_if { |kid| kid == child } && child.parent=(nil)
    end

#Searchable

    def dfs(target_value)
        return nil if self.parent = nil
        return self if self.value == target_value
        self.children.each do |child| 
            result = child.dfs(target_value)
            return result unless result.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.empty?
        node = queue.shift
            if node.value == target_value
                return node unless node.nil?
            else node.children.each { |child| queue << child }
            end
        end
        nil
    end 

end