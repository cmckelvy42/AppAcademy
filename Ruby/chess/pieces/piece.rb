
class Piece
    require "byebug"
    attr_reader :board, :color
    def initialize(color, board, pos)
        raise ArgumentError.new "invalid color" if ![:light_yellow, :black].include?(color)
        raise ArgumentError.new "invalid position" if !board.valid_pos?(pos)
        @color = color
        @board = board
        @pos = Vector2.new(*pos)
        board.add_piece(self, pos)
    end

    def inspect
        return self.symbol
    end

    def empty?
        false
    end

    def pos
        return @pos.xy
    end
    def pos=(loc)
        @pos = Vector2.new(*loc)
    end

    def valid_moves
        ret = moves.reject{|move| move_into_check?(move)}
        return ret
    end

    def move_into_check?(end_pos)
        tmp = pos
        tmpPiece = @board[end_pos]
        @board.move_piece!(pos, end_pos)
        ret = @board.check?(color)
        @board.move_piece!(pos, tmp)
        @board[end_pos] = tmpPiece
        ret
    end
end