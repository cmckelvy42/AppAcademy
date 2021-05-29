
module Slideable
    HV_DIRS = [
        Vector2.new(0,1),
        Vector2.new(0,-1),
        Vector2.new(1,0),
        Vector2.new(-1,0)
    ].freeze

    DIAG_DIRS = [
        Vector2.new(1,1),
        Vector2.new(-1,-1),
        Vector2.new(1,-1),
        Vector2.new(-1,1)
    ].freeze

    def moves
        moves = []
        move_dirs.each{|d| moves += unblocked_moves(d)}
        moves
    end
    
    private 
    def move_dirs
        # subclass implements this
        raise NotImplementedError
    end

    def unblocked_moves(dir)
        moves = []
        tmp = @pos + dir
        while board.valid_pos?(tmp.xy)
            if board.empty?(tmp.xy)
                moves << tmp.xy 
            else
                moves << tmp.xy if @board[tmp.xy].color != @color
                break
            end
            tmp += dir
        end
        moves
    end
end