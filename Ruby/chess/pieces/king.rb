require_relative "piece"
require_relative "stepable"
class King < Piece
    include Stepable
    def symbol
        " ♚ ".colorize(color)
    end
    
    protected
    
    def move_diffs
        ret = []
        for i in -1..1
            for j in -1..1
                ret << Vector2.new(i,j) unless i == 0 && j == 0
            end
        end
        ret
    end
end
