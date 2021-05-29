require_relative "00_tree_node"
require "set"
class KnightPathFinder
    def initialize(location)
        @root_node = PolyTreeNode.new(location)
        @considered_positions = Set.new
        @considered_positions.add(location)
        build_move_tree
    end

    def valid_moves(pos)
        ret = []
        for i in -2..2
            next if i == 0
            for j in -2..2
                next if j == 0 || i.abs == j.abs
                x = pos[0] + i
                y = pos[1] + j 
                ret << [x,y] if x >= 0 && y >= 0 && x < 8 && y < 8
            end
        end
        return ret
    end

    def new_move_positions(pos)
        possible = valid_moves(pos)
        possible.reject!{|e| @considered_positions.include?(e)}
        possible.each{|e| @considered_positions.add(e)}
        return possible
    end

    def build_move_tree
        queue = [@root_node]
        while !queue.empty?
            tmp = queue.shift
            moves = new_move_positions(tmp.value)
            moves.each{|e| tmp.add_child(PolyTreeNode.new(e))}
            tmp.children.each{|e| queue << e}
        end
    end

    def find_path(end_pos)
        node = @root_node.dfs(end_pos)

        path = trace_back_path(node)
        path
    end
    def trace_back_path(node)
        ret = [node.value]
        until node == @root_node
            node = node.parent
            ret.unshift(node.value)
        end
        ret
    end
end
puts "start location"
start = gets.chomp.split(',').map{|e| e.to_i}
puts "target location"
target = gets.chomp.split(',').map{|e| e.to_i}
p KnightPathFinder.new(start).find_path(target)
