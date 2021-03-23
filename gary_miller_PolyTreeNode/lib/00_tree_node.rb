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

end