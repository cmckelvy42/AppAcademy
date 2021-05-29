require_relative "piece"
require_relative "stepable"
class Pawn < Piece


    def symbol
        " ♟ ".colorize(color)
    end

    def moves
        forward_moves + side_attacks
    end
    
    private
    def at_start_row?
        @pos.xy[1] == ((color == :black) ? 1 : 6)
    end
    
    def forward_moves
        ret = []
        case color
        when :light_yellow
            adv1 = @pos + Vector2.new(0,-1)
            adv2 = @pos + Vector2.new(0,-2)
        when :black
            adv1 = @pos + Vector2.new(0,1)
            adv2 = @pos + Vector2.new(0,2)
        end
        ret << adv1.xy if board.valid_pos?(adv1.xy) && board.empty?(adv1.xy)
        ret << adv2.xy if at_start_row? && board.valid_pos?(adv2.xy) && board.empty?(adv2.xy)
        ret
    end

    def side_attacks
        ret = []
        case color
        when :light_yellow
            adv1 = @pos + Vector2.new(-1,-1)
            adv2 = @pos + Vector2.new(1,-1)
        when :black
            adv1 = @pos + Vector2.new(1,1)
            adv2 = @pos + Vector2.new(-1,1)
        end
        ret << adv1.xy if board.valid_pos?(adv1.xy) && board[adv1.xy].color != color && board[adv1.xy] != NullPiece.instance && !board[adv1.xy].empty?
        ret << adv2.xy if board.valid_pos?(adv2.xy) && board[adv2.xy].color != color && board[adv2.xy] != NullPiece.instance && !board[adv2.xy].empty?
        ret
    end
end