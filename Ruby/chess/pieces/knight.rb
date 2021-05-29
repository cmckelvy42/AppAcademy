require_relative "piece"
require_relative "stepable"
class Knight < Piece
    include Stepable
    def symbol
        " ♞ ".colorize(color)
    end
    
    protected
    
    def move_diffs
        ret = []
        for i in -2..2
            next if i == 0
            for j in -2..2
                next if j == 0 || i.abs == j.abs
                ret << Vector2.new(i,j)
            end
        end
        ret
    end
end