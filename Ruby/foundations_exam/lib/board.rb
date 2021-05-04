class Board
    attr_reader :max_height

    def self.build_stacks(numStacks)
        return Array.new(numStacks){Array.new}
    end

    def initialize(numStacks, maxHeight)
        raise "rows and cols must be >= 4" if numStacks < 4 || maxHeight < 4
        @max_height = maxHeight
        @stacks = Board.build_stacks(numStacks)
    end
    # This Board#print method is given for free and does not need to be modified
    # It is used to make your game playable.
    def print
        @stacks.each { |stack| p stack }
    end

    def add(token, stack)
        if @stacks[stack].size < @max_height    
            @stacks[stack] << token
            return true
        end
        return false
    end

    def vertical_winner?(token)
        @stacks.each{|s| return true if s.count(token) == @max_height}
        return false
    end

    def horizontal_winner?(token)
        for j in 0...tallest_stack
            for i in 0...@stacks.size
                break if @stacks[i][j] != token
            end
            return true if i == @stacks.size - 1
        end
        return false

    end

    def tallest_stack
        tallest = 0
        @stacks.each{|s| tallest = s.size if s.size > tallest}
        return tallest
    end

    def winner?(token)
        return horizontal_winner?(token) || vertical_winner?(token)
    end
end
