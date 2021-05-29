class Vector2
    attr_reader :xy
    def initialize(x,y)
        @xy = [x,y]
    end
    def set(x, y)
        @xy = [x,y]
    end

    def inspect
        @xy
    end

    def +(rhs)
        raise "Not a vector!" unless rhs.is_a?(Vector2)
        curx,cury = @xy
        addx,addy = rhs.xy
        Vector2.new(curx + addx, cury + addy)
    end
end