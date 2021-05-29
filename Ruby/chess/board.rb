require_relative "pieces"
class Board
    attr_reader :rows

    def initialize
        initialize_board
        @null = NullPiece.instance
    end
    
    def valid_pos?(pos)
        pos.all?{|e| e >= 0 && e <= 7}
    end

    def [](pos)
        if !valid_pos?(pos)
            require "byebug"
            debugger
            raise 'invalid pos' 
        end
        col, row = pos
        @rows[row][col]
    end

    def []=(pos, piece)
        raise 'invalid pos' unless valid_pos?(pos)
    
        col, row = pos
        @rows[row][col] = piece
    end

    def empty?(pos)
        self[pos].empty?
    end

    def move_piece(turn_color, start_pos, end_pos)
        raise "No piece at specified location!" if empty?(start_pos)
        piece = self[start_pos]
        raise "Not your piece" if turn_color != piece.color
        raise "Piece cannot move like that" unless piece.moves.include?(end_pos)
        raise "Cannot move into check" unless piece.valid_moves.include?(end_pos)
        move_piece!(start_pos, end_pos)
    end

    def move_piece!(start_pos, end_pos)
        self[end_pos] = self[start_pos]
        self[start_pos] = NullPiece.instance
        self[end_pos].pos = end_pos
    end

    def add_piece(piece, pos)
        self[pos] = piece
    end

    def check?(color)
        king_pos = find_king(color)
        pieces.any?{|e| e.moves.include?(king_pos) && e.color != color}
    end

    def checkmate?(color)
        return false unless check?(color)
        debugger
        pieces.select{|p| p.color == color}.all?{|p| p.valid_moves.empty?}
    end
        

    private
    attr_reader :null

    def fill_back_row(color)
        color == :black ? row = 0 : row = 7
        back_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        for i in 0...back_pieces.size
            @rows[row][i] = back_pieces[i].new(color, self, [i,row])
        end
    end

    def fill_pawns(color)
        color == :black ? row = 1 : row = 6
        for i in 0..7
            @rows[row][i] = Pawn.new(color, self, [i,row])
        end
    end

    def initialize_board

        @rows = Array.new(8){Array.new(8, NullPiece.instance)}
        [:light_yellow, :black].each do |c| 
            fill_back_row(c)
            fill_pawns(c)
        end
    end

    def pieces
        @rows.flatten.reject(&:empty?)
    end

    def find_king(color)
        pieces.each{|p| return p.pos if p.is_a?(King) && p.color == color}
    end

    
end