module Stepable
    def moves
        possibilities = move_diffs.map{|e| (e + @pos).xy}
        possibilities.select{|e| valid_move?(e)}
    end

    private
    def move_diffs
        # subclass implements this
        raise NotImplementedError
    end

    def valid_move?(loc)
        return board.valid_pos?(loc) && (board.empty?(loc) || board[loc].color != color && board[loc]!= NullPiece.instance)
    end
end