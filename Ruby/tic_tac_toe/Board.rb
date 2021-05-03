require "byebug"
class Board
    attr_reader :board
    def initialize(size)
        @board = Array.new(size){Array.new(size, '_')}
    end

    def valid?(position)
         if position.size == 2 && position.all?{|e| e < @board.size && e >= 0}
            return true
         else
            return false
         end
    end

    def empty?(position)
        return valid?(position) && @board[position[0]][position[1]] == '_'
    end
    
    def print
        $stdout.print("  ")
        @board.size.times {|i| $stdout.print "#{i+1} "}
        $stdout.print("\n")
        @board.each_with_index do |r, j|
            $stdout.print "#{j+1} "
            
            r.each_with_index do |e, i|
                
                $stdout.print e
                i < @board.size - 1 ? $stdout.print(' ') : $stdout.print("\n")
            end
            puts ""
        end
        puts "\n"
    end

    def place_mark(position, mark)
        if empty?(position)
            @board[position[0]][position[1]] = mark
            return true
        end
        return false
    end

    def win_row?(mark)
        @board.each{|r| return true if r.all?{|e| e == mark}}
        return false
    end

    def win_col?(mark)
        for i in 0..@board.size - 1
            return true if @board.all?{|r| r[i] == mark}
        end
        return false
    end

    def win_diagonal?(mark)
        diag1 = []
        diag2 = []
        for i in 0..@board.size - 1
            j = @board.size - 1 - i
            diag1 << @board[i][i]
            diag2 << @board[i][j]
        end
        return diag1.all?{|e| e == mark} || diag2.all?{|e| e == mark}
    end

    def win?(mark)
        return win_col?(mark) || win_row?(mark) || win_diagonal?(mark)
    end

    def empty_positions? 
        @board.each do |r|
            return true if r.any?{|e| e == "_"}
        end
        return false
    end

    def legal_positions
        ret = []
        @board.each_index do |y|
            @board[y].each_index{|x| ret << [y, x] if empty?([y, x])}
        end
        ret
    end

    def clear_mark(position)
        @board[position[0]][position[1]] = "_"
    end
end