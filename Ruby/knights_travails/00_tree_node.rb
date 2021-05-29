require "byebug"
class PolyTreeNode
    attr_reader :value, :children, :parent
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(par)
        @parent.remove_child(self) if par != nil && @parent != nil
        par.add_child(self) if par != nil
        @parent = par
    end

    def add_child(node)
        if @children.include?(node) == false
            @children << node
            node.parent=self
        end
    end

    def remove_child(child)
        if @children.include?(child)
            child.parent = nil
            @children.delete(child)
        else
            raise "Not a child"
        end
    end

    def inspect
        return @value
    end

    def dfs(value)
        return self if @value == value
            @children.each do |e| 
                result = e.dfs(value)
                return result if result != nil
            end
        return nil
    end

    def bfs(value)
        queue = [self]
        while !queue.empty?
            tmp = queue.shift
            return tmp if tmp.value == value
            tmp.children.each{|e| queue << e}
        end
        return nil

    end

end
